import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/widgets/buttons/auth_button.dart';
import 'dart:developer';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("Called");
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackgroundImage(
        opacity: .85,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              Image.asset("assets/images/logo.png"),
              // SizedBox was necessary to resize the TextButton
              SizedBox(
                width: MediaQuery.of(context).size.width * .80,
                height: 50,
                // TODO: Implement onPress feature
                child: AuthButton(title: "START CATCHING", onPressed: () {}),
              ),
              Text(
                "Show your friends how green your world can grow.",
                style: kSmallTextStyle.copyWith(
                    fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
