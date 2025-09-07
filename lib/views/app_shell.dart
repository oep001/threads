import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/views/create_post_screen.dart';

import '../constants/app_colors.dart';
import '../widgets/navigation_bar.dart'; // 분리된 바 파일

class AppShell extends StatelessWidget {
  final StatefulNavigationShell shell;
  final void Function(int index)? onIndexChanged;

  const AppShell({
    super.key,
    required this.shell,
    this.onIndexChanged,
  });

  int get _selectedUiIndex {
    final b = shell.currentIndex;
    return b < 2
        ? b
        : b + 1; // 0,1 -> 0,1 / 2,3 -> 3,4 (가운데 Post 슬롯 건너뜀)
  }

  void _onTap(BuildContext context, int uiIndex) {
    if (uiIndex == 2) {
      // compose는 액션(모달)
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: CreatePostScreen(
            avatarUrl:
                'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face',
          ),
        ),
      );
      return;
    }
    // UI index -> branch index 매핑
    final branchIndex = uiIndex < 2 ? uiIndex : uiIndex - 1;
    shell.goBranch(branchIndex);
    onIndexChanged?.call(uiIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell, // 화면 전체는 shell이 그림
      bottomNavigationBar: AppNavBar(
        selectedIndex: _selectedUiIndex,
        onSelected: (i) => _onTap(context, i),
        backgroundColor: AppColors.systemBackground(context),
        selectedColor: AppColors.label(context),
        unselectedColor: AppColors.quaternaryLabel(context),
      ),
    );
  }
}
