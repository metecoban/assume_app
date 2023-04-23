import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/core/base/service/base_firestore.dart';
import 'package:assume/core/model/user/request/user_request.dart';
import 'package:assume/core/model/user/response/user_response.dart';
import 'package:assume/core/service/local/hive/mission_cache.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/network/firebase/auth/auth_services.dart';
import 'package:assume/core/utils/dynamic_localization/dynamic_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService extends IBaseFirestore {
  static final LoginService _instance = LoginService._init();
  static LoginService get instance => _instance;
  LoginService._init() : super(path: 'users');

  static L10n _l10n = DynamicLocalization.l10n;
  static void updateL10N() {
    _l10n = DynamicLocalization.l10n;
  }

  login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user == null) {
        return UserResponse(
            success: false, data: null, message: _l10n.emailOrPasswordWrong);
      }
      final snapshot = await super.fetchOneData(credential.user!.uid);
      if (snapshot.data() != null) {
        UserRequest user = UserRequest.fromJson(snapshot.data());
        UserCacheService.instance.saveUser(user);
        return UserResponse(success: true, data: user, message: null);
      } else {
        return UserResponse(
            success: false, data: null, message: _l10n.userNotFound);
      }
    } on FirebaseAuthException {
      return UserResponse(
          success: false,
          data: null,
          message: _l10n.emailOrPasswordWrong /* e.message */);
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }

  logOut() {
    try {
      auth.signOut();
      UserCacheService.instance.deleteUser();
      MissionCacheService.instance.clearMissions();
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }

  //LOGIN WITH GOOGLE
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future<UserResponse> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return UserResponse(
            success: false, data: null, message: _l10n.anErrorOccured);
      }
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = UserRequest(
        id: FirebaseAuth.instance.currentUser!.uid,
        email: FirebaseAuth.instance.currentUser!.email,
        name: FirebaseAuth.instance.currentUser!.displayName,
        createdAt: DateTime.now(),
      );
      await RegisterService.instance.register(user: user, isGoogle: true);
      return UserResponse(
          success: true, data: user, message: _l10n.successfullyLoggedIn);
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    UserCacheService.instance.deleteUser();
    MissionCacheService.instance.clearMissions();
  }

  //LOGIN WITH ANONYMOUS
  Future<UserResponse> loginAnonymous() async {
    try {
      var userCredential = await auth.signInAnonymously();

      User? user = userCredential.user;
      if (user != null) {
        final userRequest = UserRequest(
          id: user.uid,
          email: user.email,
          name: user.displayName,
          createdAt: DateTime.now(),
        );
        await RegisterService.instance
            .register(user: userRequest, isGoogle: true);
        return UserResponse(
            success: true,
            data: userRequest,
            message: _l10n.successfullyLoggedIn);
      } else {
        return UserResponse(
            success: false, data: null, message: _l10n.anErrorOccured);
      }
    } catch (e) {
      return UserResponse(success: false, data: null, message: e.toString());
    }
  }
}
