import 'package:botanicatch/screens/home/home_screen.dart';
import 'package:botanicatch/screens/home/profile_screen.dart';
import 'package:botanicatch/widgets/buttons/camera_fab.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/widgets/navbars/custom_bottom_navbar.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  late final ValueNotifier<int> _currentScreenIndex;

  static const List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];

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
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: ValueListenableBuilder(
          valueListenable: _currentScreenIndex,
          builder: (context, index, _) => _screens[index]),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndexNotifier: _currentScreenIndex,
        onDestinationSelect: (int index) => _navigateOnPress(index),
      ),
      // TODO: Implement onPress function
      floatingActionButton: Visibility(
          visible: !keyboardIsOpened, child: CameraFab(onPressed: () {})),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
