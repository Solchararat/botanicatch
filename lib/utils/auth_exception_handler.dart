import 'dart:developer';

enum AuthResultStatus {
  successful,
  channelError,
  emailAddressAlreadyExists,
  wrongPassword,
  invalidCredential,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined
}

class AuthExceptionHandler {
  static handleException(e) {
    log("Code @handleException: ${e.code}");
    log(e.message);
    log("${e.code == "channel-error"}");
    AuthResultStatus status;

    switch (e.code) {
      case "channel-error":
        status = AuthResultStatus.channelError;
        log("$status");
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAddressAlreadyExists;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "invalid-credential":
        status = AuthResultStatus.invalidCredential;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      default:
        status = AuthResultStatus.undefined;
        break;
    }
    return status;
  }

  static generateExceptionMessage(exceptionCode) {
    String errorMsg;

    switch (exceptionCode) {
      case AuthResultStatus.channelError:
        errorMsg = "Email and password cannot be empty.";
        break;
      case AuthResultStatus.invalidCredential:
        errorMsg = "Invalid email address or password.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMsg = "Wrong password. It seems your password is incorrect.";
        break;
      case AuthResultStatus.userNotFound:
        errorMsg = "User not found.";
        break;
      case AuthResultStatus.userDisabled:
        errorMsg = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMsg = "Too many requests. Please try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMsg = "Signing in with email and password is not enabled.";
        break;
      case AuthResultStatus.emailAddressAlreadyExists:
        errorMsg =
            "The email has already been registered. Please login instead.";
        break;
      default:
        errorMsg = "An undefined error happened.";
        break;
    }
    return errorMsg;
  }
}
