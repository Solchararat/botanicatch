import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/screens/wrapper.dart';
import 'dart:async';

class VerifyEmailScreen extends StatefulWidget {
  final String? email;
  const VerifyEmailScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  static final AuthService _auth = AuthService();
  late final Timer _timer;

  @override
  void initState() {
    _auth.sendVerificationEmail();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _auth.currentUser?.reload();
      if (_auth.currentUser!.emailVerified) {
        timer.cancel();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Wrapper()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackgroundImage(
        imagePath: "assets/images/bg.png",
        opacity: .80,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 16),
                Text(
                  "Confirm your email address",
                  style: kMediumTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const Expanded(child: SizedBox()),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: "We sent a confirmation email to:\n",
                          style: kSmallTextStyle),
                      TextSpan(
                          text: "${widget.email}\n",
                          style: kSmallTextStyle.copyWith(
                              fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text:
                              "Check your email and click on the confirmation link to continue.",
                          style: kSmallTextStyle),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                    onPressed: () async {
                      await _auth.sendVerificationEmail();
                    },
                    child: Text(
                      "Resend email",
                      style: kSmallTextStyle.copyWith(color: kGreenColor300),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
