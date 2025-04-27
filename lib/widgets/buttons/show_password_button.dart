import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class ShowPasswordButton extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onToggle;

  const ShowPasswordButton({
    super.key,
    required this.isVisible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: kGreenColor300,
      ),
    );
  }
}
