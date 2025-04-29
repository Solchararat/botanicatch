import 'package:botanicatch/utils/constants.dart';
import 'package:flutter/material.dart';

class NavbarIconButton extends StatelessWidget {
  final int index;
  final IconData iconData;
  final String label;
  final ValueNotifier<int> selectedIndexNotifier;
  final Function(int) onSelected;

  const NavbarIconButton({
    super.key,
    required this.index,
    required this.iconData,
    required this.label,
    required this.selectedIndexNotifier,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndexNotifier,
      builder: (context, selectedIndex, _) {
        final isSelected = selectedIndex == index;
        return InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () => onSelected(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(iconData,
                  color: isSelected ? kGreenColor300 : kGrayColor250),
              Text(label,
                  style: kXXSmallTextStyle.copyWith(
                      color: isSelected ? kGreenColor300 : kGrayColor250,
                      fontSize: 10))
            ],
          ),
        );
      },
    );
  }
}
