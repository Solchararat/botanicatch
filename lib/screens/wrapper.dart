import 'package:botanicatch/screens/auth/authenticate.dart';
import 'package:botanicatch/screens/auth/verify_email_screen.dart';
import 'package:botanicatch/screens/home/home_wrapper.dart';
import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  static final AuthService _auth = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kGreenColor500,
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _LoadingIndicator();
          }
          if (snapshot.hasError) {
            return const Center(child: Text("An error has occurred."));
          }
          final user = snapshot.data;
          if (user != null) {
            _validateUserToken(user);
          }
          return _buildAuthenticatedContent(user);
        },
      ),
    );
  }

  void _validateUserToken(User user) {
    user.getIdToken(true).catchError((_) {
      _auth.signOut();
      return null;
    });
  }

  Widget _buildAuthenticatedContent(User? user) {
    if (user == null) {
      return const Authenticate();
    }

    return user.emailVerified
        ? const HomeWrapper()
        : VerifyEmailScreen(email: user.email);
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: kGreenColor500,
        color: kGreenColor300,
      ),
    );
  }
}
