import 'package:flutter/material.dart';
import 'package:botanicatch/screens/auth/login_screen.dart';
import 'package:botanicatch/screens/auth/register_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showLoginScreen = true;

  void _toggleView() => setState(() => _showLoginScreen = !_showLoginScreen);

  @override
  Widget build(BuildContext context) {
    return _showLoginScreen
        ? LoginScreen(toggleView: _toggleView)
        : RegisterScreen(toggleView: _toggleView);
  }
}
