import 'dart:developer';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/services/db/db_service.dart';
import 'package:botanicatch/utils/auth_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._internal();
  static AuthService? _instance;
  static AuthService get instance => _instance ??= AuthService._internal();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  late AuthResultStatus _status;

  UserModel? _userFromFirebase(User? user) =>
      user != null ? UserModel(uid: user.uid, email: user.email) : null;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Stream<UserModel?> get user =>
      _auth.authStateChanges().asyncExpand((User? user) {
        if (user == null) return Stream.value(null);

        final db = DatabaseService(uid: user.uid);
        return db.userModel.map((model) => model);
      });

  User? get currentUser => _auth.currentUser;

  // Send verification email
  Future sendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      log("Exception @sendVerificationEmail: $e");
      _status = AuthExceptionHandler.handleException(e);
    }
  }

  // Reset password
  Future<AuthResultStatus> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _status = AuthResultStatus.successful;
    } catch (e) {
      log("Exception @resetPassword: $e");
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  // Register
  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserModel? userModel;

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final User? user = result.user;
      if (user == null) throw Exception("User registration failed");

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData(username: "Guest", email: user.email);

      _status = AuthResultStatus.successful;
      return (_status, _userFromFirebase(user));
    } catch (e) {
      log("Exception @signUpWithEmailAndPassword: $e");
      _status = AuthExceptionHandler.handleException(e);
    }
    return (_status, userModel);
  }

  // login
  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      if (user == null) throw Exception("User login failed");

      _status = AuthResultStatus.successful;
      return (_status, _userFromFirebase(user));
    } catch (e) {
      log("Exception @signInWithEmailAndPassword: $e");
      _status = AuthExceptionHandler.handleException(e);
      return (_status, null);
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      log("Exception @signOut: $e");
      _status = AuthExceptionHandler.handleException(e);
    }
  }

  Future<void> clearAuthCache() async {
    try {
      await _auth.signOut();
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      log("Exception @clearAuthCache: $e");
    }
  }

  void checkAuthValidity(User? user) async {
    if (user != null) {
      try {
        await user.getIdToken(true);
      } catch (e) {
        await AuthService.instance.signOut();
      }
    }
  }
}
