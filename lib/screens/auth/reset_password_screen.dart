import 'package:botanicatch/utils/auth_exception_handler.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/screens/wrapper.dart';
import 'package:botanicatch/services/auth_service.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/utils/extensions.dart';
import 'package:botanicatch/widgets/buttons/auth_button.dart';
import 'package:botanicatch/widgets/textformfields/custom_textformfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final TextEditingController _email;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final AuthService _auth = AuthService();

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _resetPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final BuildContext currentContext = context;

      AuthResultStatus status =
          await _auth.resetPassword(email: _email.text.toLowerCase().trim());

      if (status == AuthResultStatus.successful && currentContext.mounted) {
        Navigator.pushReplacement(currentContext,
            MaterialPageRoute(builder: (context) => const Wrapper()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackgroundImage(
        opacity: .80,
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Image.asset("assets/images/logo.png"),
                  Column(
                    children: [
                      Text("RESET PASSWORD",
                          style: kMediumTextStyle.copyWith(
                              fontWeight: FontWeight.bold)),
                      const Text(
                          "Please enter your email address to reset your password.",
                          style: kSmallTextStyle),
                      const SizedBox(height: 16),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: CustomTextFormField(
                      validator: (value) => value == null || !value.isValidEmail
                          ? "Invalid email address."
                          : null,
                      hintText: "Email",
                    ),
                  ),
                  AuthButton(
                      title: "Next", onPressed: () => _resetPassword(context))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
