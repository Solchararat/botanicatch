import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/services/auth_service.dart';
import 'package:botanicatch/widgets/navbars/custom_bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<int> _currentScreenIndex;

  static final AuthService _auth = AuthService();

  void _navigateOnPress(int index) {
    _currentScreenIndex.value = index;
  }

  @override
  void initState() {
    super.initState();
    _currentScreenIndex = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _currentScreenIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenColor400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "You are now logged in!",
              style: kSmallTextStyle,
            ),
            TextButton(
                onPressed: () {
                  _auth.signOut();
                },
                child: Text(
                  "Log Out",
                  style: kSmallTextStyle.copyWith(color: kGreenColor300),
                ))
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndexNotifier: _currentScreenIndex,
        onDestinationSelect: (int index) => _navigateOnPress(index),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 0,
          backgroundColor: kGreenColor300,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 5, color: kGreenColor500),
              borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
