import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/core/base/service/base_firestore.dart';
import 'package:assume/core/model/result/result_response.dart';
import 'package:assume/core/service/network/mailer/email_service.dart';
import 'package:assume/core/utils/crypto/password_utils.dart';
import 'package:assume/core/utils/dynamic_localization/dynamic_localization.dart';

class ResetPasswordService extends IBaseFirestore {
  static final ResetPasswordService _instance = ResetPasswordService._init();
  static ResetPasswordService get instance => _instance;
  ResetPasswordService._init() : super(path: 'users');

  static L10n _l10n = DynamicLocalization.l10n;
  static void updateL10N() {
    _l10n = DynamicLocalization.l10n;
  }

  Future<ResultResponse> otpControl(String email, String otp) async {
    try {
      final snapshot = await collection.where('email', isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        if (snapshot.docs.first['otpCode'] == int.parse(otp)) {
          await super.updateData({'otpCode': null}, snapshot.docs.first.id);
          return ResultResponse(success: true, message: _l10n.codeIsCorrect);
        } else {
          return ResultResponse(success: false, message: _l10n.codeNotCorrect);
        }
      } else {
        return ResultResponse(success: false, message: _l10n.emailNotFound);
      }
    } catch (e) {
      return ResultResponse(success: false, message: _l10n.anErrorOccured);
    }
  }

  Future resetPassword(String email, String password, String password2) async {
    try {
      final snapshot = await collection.where('email', isEqualTo: email).get();

      if (!_passwordSimilarity(password, password2)) {
        return ResultResponse(success: false, message: _l10n.passwordsNotSame);
      }
      if (snapshot.docs.isNotEmpty) {
        String cleanPassword =
            PasswordUtils.instance.decrypt(snapshot.docs.first['password']);
        await auth.signInWithEmailAndPassword(
            email: email, password: cleanPassword);
        await auth.currentUser!.updatePassword(password);
        password = await PasswordUtils.instance.encrypt(password);
        await super.updateData({'password': password}, snapshot.docs.first.id);
        return ResultResponse(
            success: true, message: _l10n.passwordChangedSuccesfully);
      } else {
        return ResultResponse(success: false, message: _l10n.userNotFound);
      }
    } catch (e) {
      return ResultResponse(success: false, message: _l10n.anErrorOccured);
    }
  }

  //TODO: Timer will be added
  Future<ResultResponse> sendPasswordResetCode(String email) async {
    try {
      int otp = EmailService.instance.generateOTP();
      final snapshot = await collection.where('email', isEqualTo: email).get();
      if (snapshot.docs.isNotEmpty) {
        await super.updateData({'otpCode': otp}, snapshot.docs.first.id);
        EmailService.instance.sendOTPEmail(email, otp);
        return ResultResponse(
            success: true, message: _l10n.codeSentEmailSuccessfully);
      } else {
        return ResultResponse(success: false, message: _l10n.userNotFound);
      }
    } catch (e) {
      return ResultResponse(success: false, message: _l10n.errorResetPassword);
    }
  }

  bool _passwordSimilarity(String password, String password2) {
    return password == password2;
  }
}
