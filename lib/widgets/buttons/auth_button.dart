import 'package:flutter/material.dart';
import 'package:botanicatch/utils/constants.dart';

class AuthButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const AuthButton({super.key, required this.title, required this.onPressed});

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(kGreenColor100),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: kGreenColor100),
          ),
        ),
      ),
      child: Text(
        widget.title,
        style: kSmallTextStyle.copyWith(
            color: kGreenColor500, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
