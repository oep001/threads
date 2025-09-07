import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;

  const AppNavBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: backgroundColor,
        indicatorColor: Colors.transparent,
        // Flutter 버전에 따라 아래 둘 중 하나 사용
        // iconTheme: WidgetStateProperty.resolveWith(
        //   (states) => IconThemeData(
        //     color: states.contains(WidgetState.selected)
        //         ? selectedColor
        //         : unselectedColor,
        //   ),
        // ),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? selectedColor
                : unselectedColor,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onSelected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 56,
        destinations: const [
          NavigationDestination(
            icon: Icon(CupertinoIcons.home, size: 32),
            selectedIcon: Icon(CupertinoIcons.house_fill, size: 32),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.search, size: 32),
            selectedIcon: Icon(CupertinoIcons.search, size: 32),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.plus_square, size: 32),
            selectedIcon: Icon(
              CupertinoIcons.plus_square_fill,
              size: 32,
            ),
            label: 'Post',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.heart, size: 32),
            selectedIcon: Icon(CupertinoIcons.heart_fill, size: 32),
            label: 'Likes',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.person, size: 32),
            selectedIcon: Icon(CupertinoIcons.person_fill, size: 32),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
