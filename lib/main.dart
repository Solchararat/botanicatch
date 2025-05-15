import 'package:botanicatch/services/shared_preferences/shared_preferences_service.dart';
import 'package:botanicatch/screens/auth/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:botanicatch/screens/auth/start_screen.dart';
import 'package:botanicatch/services/auth/auth_service.dart';
import 'package:botanicatch/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const List<String> svgAssets = <String>[
    "assets/images/badge.svg",
    "assets/images/botanicatch.svg",
    "assets/images/diagnose-plant.svg",
    "assets/images/first-leaf-badge.svg",
    "assets/images/found-plant.svg",
    "assets/images/leaf-collector-badge.svg",
    "assets/images/native-botanist-badge.svg",
    "assets/images/new-plants.svg",
    "assets/images/plantdex-apprentice-badge.svg",
    "assets/images/settings.svg",
    "assets/images/your-plants.svg",
  ];
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    SharedPrefsService.instance.init(),
    ...svgAssets.map((path) {
      final loader = SvgAssetLoader(path);
      final key = loader.cacheKey(null);
      return svg.cache.putIfAbsent(key, () => loader.loadBytes(null));
    }),
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
        home: Scaffold(
          extendBody: true,
          body: SplashWrapper(),
        ),
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
