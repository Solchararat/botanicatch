import 'dart:developer';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/utils/auth_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final AuthService _authService = AuthService._internal();

  factory AuthService() => _authService;

  AuthService._internal();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  late AuthResultStatus _status;

  UserModel? _userFromFirebase(User? user) =>
      user != null ? UserModel(uid: user.uid, email: user.email) : null;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Stream<UserModel?> get user =>
      _auth.authStateChanges().map(_userFromFirebase);
  User? get currentUser => _auth.currentUser;

  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserModel? userModel;

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      if (user != null) {
        _status = AuthResultStatus.successful;
        userModel = _userFromFirebase(user);
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      log("Exception @signInWithEmailAndPassword: $e");
      _status = AuthExceptionHandler.handleException(e);
    }
    return (_status, userModel);
  }

  // Sign in
  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserModel? userModel;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      if (user != null) {
        userModel = _userFromFirebase(user);
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      log("Exception @signInWithEmailAndPassword: $e");
      _status = AuthExceptionHandler.handleException(e);
    }
    return (_status, userModel);
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
}
