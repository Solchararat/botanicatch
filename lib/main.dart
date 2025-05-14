import 'package:botanicatch/services/shared_preferences/shared_preferences_service.dart';
import 'package:botanicatch/screens/auth/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/screens/auth/start_screen.dart';
import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    SharedPrefsService.instance.init(),
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/bg.png"), context);
    precacheImage(const AssetImage("assets/images/home-bg.jpg"), context);

    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          initialData: null,
          value: AuthService.instance.user,
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashWrapper(),
      ),
    );
  }
}

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
  }

  bool _showOnboarding = true;

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return OnboardingScreen(
        onComplete: () {
          setState(() {
            _showOnboarding = false;
          });
        },
      );
    } else {
      return const StartScreen();
    }
  }
}
