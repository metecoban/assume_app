import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static final EmailService _instance = EmailService._init();
  static EmailService get instance => _instance;
  EmailService._init();

  void sendOTPEmail(String emailAddress, int otp) async {
    final smtpServer =
        gmail(dotenv.env['MY_EMAIL'] ?? '', dotenv.env['MY_PASSWORD'] ?? '');
    final message = Message()
      ..from = Address(dotenv.env['MY_EMAIL'] ?? '')
      ..recipients.add(emailAddress)
      ..subject = "Regarding Your Password Request"
      ..text =
          "Hello,\n\nWe have received a password creation request on our platform, Assume app.\nHere is the password that has been generated upon your request:\n\nOTP Code: $otp\n\nIf you believe that this request was not made by you, please contact us at mete.coban@hotmail.com\n\nBest regards,\nAssume App Team";

    try {
      final sendReport = await send(message, smtpServer);
      Logger().i(sendReport);
    } on MailerException catch (e) {
      Logger().e('Message not sent. $e');
      for (var p in e.problems) {
        Logger().e('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  int generateOTP() {
    var random = Random();
    return random.nextInt(8999) + 1000;
  }
}
