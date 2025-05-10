import 'dart:async';

import 'package:botanicatch/screens/home/camera_screen.dart';
import 'package:botanicatch/screens/home/garden_screen.dart';
import 'package:botanicatch/screens/home/home_screen.dart';
import 'package:botanicatch/screens/home/maps_screen.dart';
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
  late final ValueNotifier<bool> _isNavBarVisible;
  Timer? _hideNavBarTimer;

  static const List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
    CameraScreen(),
    GardenScreen(),
    MapsScreen(),
  ];

  void _navigateOnPress(int index) {
    _currentScreenIndex.value = index;
    _resetNavBarVisibility();
  }

  void _resetNavBarVisibility() {
    _isNavBarVisible.value = true;
    _hideNavBarTimer?.cancel();
    _hideNavBarTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _isNavBarVisible.value = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _currentScreenIndex = ValueNotifier<int>(0);
    _isNavBarVisible = ValueNotifier<bool>(true);
    _resetNavBarVisibility();
  }

  @override
  void dispose() {
    _currentScreenIndex.dispose();
    _isNavBarVisible.dispose();
    _hideNavBarTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: GestureDetector(
        onTap: _resetNavBarVisibility,
        child: ValueListenableBuilder<int>(
          valueListenable: _currentScreenIndex,
          builder: (context, index, _) => _screens[index],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: _isNavBarVisible,
        builder: (context, isVisible, _) {
          return AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: CustomBottomNavBar(
              selectedIndexNotifier: _currentScreenIndex,
              onDestinationSelect: _navigateOnPress,
            ),
          );
        },
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isNavBarVisible,
        builder: (context, isVisible, _) {
          final showFab = isVisible && !keyboardIsOpened;
          return AnimatedOpacity(
            opacity: showFab ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: CameraFab(
              onPressed: () {
                _currentScreenIndex.value = 2;
                _navigateOnPress(2);
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
