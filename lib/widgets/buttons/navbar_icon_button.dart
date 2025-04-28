import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class NavbarIconButton extends StatelessWidget {
  final int index;
  final IconData iconData;
  final ValueNotifier<int> selectedIndexNotifier;
  final Function(int) onSelected;

  const NavbarIconButton({
    super.key,
    required this.index,
    required this.iconData,
    required this.selectedIndexNotifier,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, _) {
        return IconButton(
          onPressed: () => onSelected(index),
          icon: Icon(
            iconData,
            color: selectedIndex == index ? kGreenColor300 : kGrayColor250,
          ),
        );
      },
    );
  }
}
