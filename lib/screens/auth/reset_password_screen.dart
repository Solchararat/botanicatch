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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BackgroundImage(
        imagePath: "assets/images/bg.png",
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
                      SizedBox(
                        width: 300,
                        child: const Text(
                          "Please enter your registered email address to reset your password.",
                          style: kXXSmallTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  CustomTextFormField(
                    controller: _email,
                    validator: (value) => value == null || !value.isValidEmail
                        ? "Invalid email address."
                        : null,
                    hintText: "Email",
                  ),
                  SizedBox(
                    width: 120,
                    child: AuthButton(
                        title: "Next",
                        onPressed: () => _resetPassword(context)),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Note: You should use the email you used to register for this app to receive the reset password email.",
                    style: kXXSmallTextStyle.copyWith(color: kGreenColor300),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
