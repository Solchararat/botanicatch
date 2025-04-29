import 'package:botanicatch/screens/home/home_screen.dart';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/background-image/background_image.dart';
import 'package:botanicatch/widgets/buttons/camera_fab.dart';
import 'package:botanicatch/widgets/buttons/plant_action_button.dart';
import 'package:botanicatch/widgets/buttons/plant_stats_button.dart';
import 'package:botanicatch/widgets/grids/plant_action_grid.dart';
import 'package:flutter/material.dart';
import 'package:botanicatch/services/auth_service.dart';
import 'package:botanicatch/widgets/navbars/custom_bottom_navbar.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  late final ValueNotifier<int> _currentScreenIndex;

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
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: HomeScreen(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndexNotifier: _currentScreenIndex,
        onDestinationSelect: (int index) => _navigateOnPress(index),
      ),
      // TODO: Implement onPress function
      floatingActionButton: CameraFab(onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
