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
      width: MediaQuery.of(context).size.width * 1,
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: Platform.isAndroid ? 16 : 0,
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 60,
            color: kGreenColor500,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: NavbarIconButton(
                    index: 0,
                    iconData: Icons.home,
                    label: "Home",
                    selectedIndexNotifier: widget.selectedIndexNotifier,
                    onSelected: _selectNavigationItem,
                  ),
                ),
                Expanded(
                  child: NavbarIconButton(
                    index: 1,
                    iconData: Icons.person,
                    label: "Profile",
                    selectedIndexNotifier: widget.selectedIndexNotifier,
                    onSelected: _selectNavigationItem,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Expanded(
                  child: NavbarIconButton(
                    index: 2,
                    iconData: Icons.spa,
                    label: "Garden",
                    selectedIndexNotifier: widget.selectedIndexNotifier,
                    onSelected: _selectNavigationItem,
                  ),
                ),
                Expanded(
                  child: NavbarIconButton(
                    index: 3,
                    iconData: Icons.settings,
                    label: "Settings",
                    selectedIndexNotifier: widget.selectedIndexNotifier,
                    onSelected: _selectNavigationItem,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
