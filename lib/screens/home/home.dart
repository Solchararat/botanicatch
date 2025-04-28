import 'package:botanicatch/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("You are now logged in!"),
            TextButton(
                onPressed: () {
                  _auth.signOut();
                },
                child: const Text("Log Out"))
          ],
        ),
      ),
    );
  }
}
