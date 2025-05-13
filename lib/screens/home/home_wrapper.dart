import 'dart:async';
import 'dart:typed_data';

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
  late final ValueNotifier<Uint8List?> _profileImgBytes;
  late final List<Widget> _screens;
  Timer? _hideNavBarTimer;

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
    _profileImgBytes = ValueNotifier<Uint8List?>(null);
    _resetNavBarVisibility();

    _screens = [
      HomeScreen(
        profileImgBytes: _profileImgBytes,
        onNavigate: _navigateOnPress,
      ),
      ProfileScreen(profileImgBytes: _profileImgBytes),
      CameraScreen(profileImgBytes: _profileImgBytes),
      GardenScreen(profileImgBytes: _profileImgBytes),
      const MapsScreen(),
    ];
  }

  @override
  void dispose() {
    _currentScreenIndex.dispose();
    _isNavBarVisible.dispose();
    _hideNavBarTimer?.cancel();
    _profileImgBytes.dispose();
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
          return RepaintBoundary(
            child: AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: CustomBottomNavBar(
                selectedIndexNotifier: _currentScreenIndex,
                onDestinationSelect: _navigateOnPress,
              ),
            ),
          );
        },
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isNavBarVisible,
        builder: (context, isVisible, _) {
          final showFab = isVisible && !keyboardIsOpened;
          return RepaintBoundary(
            child: AnimatedOpacity(
              opacity: showFab ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: CameraFab(
                onPressed: () {
                  _currentScreenIndex.value = 2;
                  _navigateOnPress(2);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
