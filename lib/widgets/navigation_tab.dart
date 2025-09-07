import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:threads/constants/gaps.dart";

class NavigationTab extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected = false;

  const NavigationTab(this.text, {required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isSelected ? 1 : 0.6,
      duration: Duration(milliseconds: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, color: Colors.white),
          Gaps.v5,
          Text(text),
        ],
      ),
    );
  }
}
