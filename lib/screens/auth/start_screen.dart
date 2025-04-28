import 'package:botanicatch/screens/wrapper.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/widgets/buttons/auth_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackgroundImage(
        imagePath: "assets/images/bg.png",
        opacity: .80,
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
                child: AuthButton(
                    title: "START CATCHING",
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Wrapper()))),
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
