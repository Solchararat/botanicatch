import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/services/auth_service.dart';
import 'package:botanicatch/utils/auth_exception_handler.dart';
import 'package:botanicatch/widgets/buttons/auth_button.dart';
import 'package:botanicatch/widgets/buttons/show_password_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/textformfields/custom_textformfield.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/utils/extensions.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  const RegisterScreen({super.key, required this.toggleView});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final AuthService _auth = AuthService();

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final ValueNotifier<bool> _isPasswordVisibleNotifier;
  late final ValueNotifier<bool> _isConfirmPasswordVisibleNotifier;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _error = "";
  bool _isLoading = false;

  @override
  void initState() {
    _isPasswordVisibleNotifier = ValueNotifier(false);
    _isConfirmPasswordVisibleNotifier = ValueNotifier(false);
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _isPasswordVisibleNotifier.dispose();
    _isConfirmPasswordVisibleNotifier.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      var (AuthResultStatus status, UserModel? user) =
          await _auth.signUpWithEmailAndPassword(
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
              imagePath: "assets/images/bg.png",
              opacity: .75,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16,
                      children: [
                        Image.asset("assets/images/logo.png"),
                        Column(
                          children: [
                            Text("SIGNUP",
                                style: kMediumTextStyle.copyWith(
                                    fontWeight: FontWeight.bold)),
                            const Text("Please sign up to continue",
                                style: kSmallTextStyle),
                            const SizedBox(height: 16)
                          ],
                        ),
                        // Email field
                        CustomTextFormField(
                          controller: _email,
                          validator: (value) =>
                              value == null || !value.isValidEmail
                                  ? "Invalid email address."
                                  : null,
                          hintText: "Email",
                        ),
                        // Password field
                        ValueListenableBuilder(
                            valueListenable: _isPasswordVisibleNotifier,
                            builder: (context, isPasswordVisible, child) {
                              return CustomTextFormField(
                                controller: _password,
                                validator: (value) => value == null ||
                                        !value.isValidPassword
                                    ? "Password must contain:\n- At least 8 characters\n- One lowercase character\n- One uppercase character\n- One number\n- One special character"
                                    : null,
                                hintText: "Password",
                                obscureText: !isPasswordVisible,
                                suffixIcon: ShowPasswordButton(
                                  isVisible: isPasswordVisible,
                                  onToggle: () => _isPasswordVisibleNotifier
                                      .value = !isPasswordVisible,
                                ),
                              );
                            }),
                        // Confirm Password field
                        ValueListenableBuilder(
                            valueListenable: _isConfirmPasswordVisibleNotifier,
                            builder:
                                (context, isConfirmPasswordVisible, child) {
                              return CustomTextFormField(
                                controller: _confirmPassword,
                                validator: (value) =>
                                    value == null || value != _password.text
                                        ? "Value doesn't match the password."
                                        : null,
                                hintText: "Confirm Password",
                                obscureText: !isConfirmPasswordVisible,
                                suffixIcon: ShowPasswordButton(
                                  isVisible: isConfirmPasswordVisible,
                                  onToggle: () =>
                                      _isConfirmPasswordVisibleNotifier.value =
                                          !isConfirmPasswordVisible,
                                ),
                              );
                            }),
                        SizedBox(
                            width: 120,
                            child: AuthButton(
                                title: "REGISTER",
                                onPressed: () {
                                  _register();
                                })),
                        Text(_error, style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 32),

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Already have an account?\nPlease ",
                                  style: kXXSmallTextStyle.copyWith(
                                      color: kGreenColor300)),
                              TextSpan(
                                  text: "Sign in",
                                  style: kXXSmallTextStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      widget.toggleView();
                                    }),
                              TextSpan(
                                  text: " instead.",
                                  style: kXXSmallTextStyle.copyWith(
                                      color: kGreenColor300)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
