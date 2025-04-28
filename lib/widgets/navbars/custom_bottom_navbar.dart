import 'dart:io';
import 'package:botanicatch/utils/constants.dart';
import 'package:botanicatch/widgets/buttons/navbar_icon_button.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final Function(int) onDestinationSelect;
  final ValueNotifier<int> selectedIndexNotifier;
  const CustomBottomNavBar(
      {super.key,
      required this.onDestinationSelect,
      required this.selectedIndexNotifier});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  void _selectNavigationItem(int index) {
    widget.selectedIndexNotifier.value = index;
    widget.onDestinationSelect(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: Platform.isAndroid ? 16 : 0,
      ),
      child: BottomAppBar(
        elevation: 0.0,
        color: kGreenColor400,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 60,
            color: kGreenColor500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavbarIconButton(
                  index: 0,
                  iconData: Icons.home,
                  selectedIndexNotifier: widget.selectedIndexNotifier,
                  onSelected: _selectNavigationItem,
                ),
                NavbarIconButton(
                  index: 1,
                  iconData: Icons.person,
                  selectedIndexNotifier: widget.selectedIndexNotifier,
                  onSelected: _selectNavigationItem,
                ),
                const SizedBox(width: 20),
                NavbarIconButton(
                  index: 2,
                  iconData: Icons.spa,
                  selectedIndexNotifier: widget.selectedIndexNotifier,
                  onSelected: _selectNavigationItem,
                ),
                NavbarIconButton(
                  index: 3,
                  iconData: Icons.settings,
                  selectedIndexNotifier: widget.selectedIndexNotifier,
                  onSelected: _selectNavigationItem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
