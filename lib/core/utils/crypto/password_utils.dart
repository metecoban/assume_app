import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PasswordUtils {
  static final PasswordUtils _instance = PasswordUtils._init();
  static PasswordUtils get instance => _instance;
  PasswordUtils._init();

  final String _key = dotenv.env['CRYPTO_KEY'] ?? '';

  encrypt(String plainText) {
    final key = Key.fromUtf8(_key);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }

  decrypt(String encrypted) {
    final key = Key.fromUtf8(_key);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    String decrypted =
        encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv);

    return decrypted;
  }
}
