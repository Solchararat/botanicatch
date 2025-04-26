import 'package:email_validator/email_validator.dart';

extension StrExtension on String {
  bool get isValidEmail {
    return EmailValidator.validate(this);
  }

  bool get isValidPassword {
    // password should at least be greater than 8 characters
    if (length < 8) return false;
    // password should at least have one numeric character
    if (!RegExp(r"[0-9]").hasMatch(this)) return false;
    // password should at least have one lowercase character
    if (!RegExp(r"[a-z]").hasMatch(this)) return false;
    // password should at least have one uppercase character
    if (!RegExp(r"[A-Z]").hasMatch(this)) return false;
    // password should at least have one special character
    if (!RegExp(r"[^a-zA-Z0-9]").hasMatch(this)) return false;
    // password should have no whitespaces
    if (RegExp(r"\s").hasMatch(this)) return false;
    return true;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
