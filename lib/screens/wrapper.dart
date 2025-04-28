import 'package:botanicatch/screens/auth/authenticate.dart';
import 'package:botanicatch/screens/auth/verify_email_screen.dart';
import 'package:botanicatch/screens/home/home.dart';
import 'package:botanicatch/services/auth_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  static final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kGreenColor500,
      body: Stack(
        children: [
          StreamBuilder(
              stream: _auth.authStateChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: kGreenColor500,
                      color: kGreenColor300,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("An error has occured."),
                  );
                } else {
                  if (snapshot.data == null) {
                    return const Authenticate();
                  } else {
                    if (snapshot.data!.emailVerified) {
                      return const HomeScreen();
                    } else {
                      return VerifyEmailScreen(email: snapshot.data?.email);
                    }
                  }
                }
              })
        ],
      ),
    );
  }
}
