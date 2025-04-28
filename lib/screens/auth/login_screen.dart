import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/screens/auth/reset_password_screen.dart';
import 'package:botanicatch/services/auth_service.dart';
import 'package:botanicatch/utils/auth_exception_handler.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/utils/extensions.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/buttons/auth_button.dart';
import 'package:botanicatch/widgets/buttons/show_password_button.dart';
import 'package:botanicatch/widgets/textformfields/custom_textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  const LoginScreen({super.key, required this.toggleView});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final AuthService _auth = AuthService();

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final ValueNotifier<bool> _isPasswordVisibleNotifier;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _error = "";
  bool _isLoading = false;

  @override
  void initState() {
    _isPasswordVisibleNotifier = ValueNotifier(false);
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _isPasswordVisibleNotifier.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      var (AuthResultStatus status, UserModel? user) =
          await _auth.signInWithEmailAndPassword(
              email: _email.text.toLowerCase().trim(),
              password: _password.text.trim());

      if (status != AuthResultStatus.successful) {
        setState(() {
          _error = AuthExceptionHandler.generateExceptionMessage(status);
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: kGreenColor300,
          ))
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: BackgroundImage(
                opacity: .75,
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/logo.png"),
                          Column(
                            children: [
                              Text("LOGIN",
                                  style: kMediumTextStyle.copyWith(
                                      fontWeight: FontWeight.bold)),
                              const Text("Please sign in to continue",
                                  style: kSmallTextStyle),
                              const SizedBox(height: 16)
                            ],
                          ),
                          CustomTextFormField(
                            controller: _email,
                            validator: (value) =>
                                value == null || !value.isValidEmail
                                    ? "Invalid email address"
                                    : null,
                            hintText: "Email",
                          ),
                          const SizedBox(height: 16),
                          ValueListenableBuilder(
                              valueListenable: _isPasswordVisibleNotifier,
                              builder: (context, isVisible, child) {
                                return CustomTextFormField(
                                  controller: _password,
                                  validator: (value) =>
                                      value == null || !value.isValidPassword
                                          ? "Invalid password."
                                          : null,
                                  hintText: "Password",
                                  obscureText: !isVisible,
                                  suffixIcon: ShowPasswordButton(
                                    isVisible: isVisible,
                                    onToggle: () => _isPasswordVisibleNotifier
                                        .value = !isVisible,
                                  ),
                                );
                              }),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ResetPasswordScreen()));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: kXXSmallTextStyle.copyWith(
                                      color: kGreenColor300),
                                )),
                          ),

                          // SizedBox was necessary to resize the button
                          SizedBox(
                            width: 120,
                            child: AuthButton(
                                title: "LOGIN",
                                onPressed: () async {
                                  _login();
                                }),
                          ),
                          Text(_error,
                              style: const TextStyle(color: Colors.red)),

                          const SizedBox(height: 32),

                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Don't have an account? Please ",
                                    style: kXXSmallTextStyle.copyWith(
                                        color: kGreenColor300)),
                                TextSpan(
                                    text: "Sign up",
                                    style: kXXSmallTextStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.toggleView();
                                      }),
                                TextSpan(
                                    text: " first.",
                                    style: kXXSmallTextStyle.copyWith(
                                        color: kGreenColor300)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          );
  }
}
