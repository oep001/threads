import 'package:flutter/material.dart';
import 'package:threads/views/report_screen.dart';

import '../constants/app_colors.dart';
import '../constants/gaps.dart';
import '../constants/text_style.dart';

class PostActionSheet extends StatelessWidget {
  const PostActionSheet({
    super.key,
    this.onUnfollow,
    this.onMute,
    this.onHide,
    this.onReport,
  });

  /// 외부 로직 연결용 (선택)
  final VoidCallback? onUnfollow;
  final VoidCallback? onMute;
  final VoidCallback? onHide;
  final VoidCallback? onReport;

  void _popThen(BuildContext context, VoidCallback? action) {
    Navigator.pop(context);
    if (action != null) {
      Future.microtask(action);
    }
  }

  void _openReportSheet(BuildContext context) {
    final nav = Navigator.of(context, rootNavigator: true);
    nav.pop(context);
    Future.microtask(() {
      if (!nav.mounted) return;
      showModalBottomSheet(
        context: nav.context,
        useRootNavigator: true, // 작동 미확인
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SafeArea(
          top: false,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const ReportScreen(),
          ),
        ),
      );
    });
    if (onReport != null) Future.microtask(onReport!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 섹션 1: Unfollow / Mute
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondarySystemBackground(context),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person_remove,
                      color: AppColors.label(context),
                    ),
                    title: Text(
                      'Unfollow',
                      style: AppTextStyles.username(context),
                    ),
                    onTap: () => _popThen(context, onUnfollow),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: AppColors.separator(context),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.volume_off,
                      color: AppColors.label(context),
                    ),
                    title: Text(
                      'Mute',
                      style: AppTextStyles.username(context),
                    ),
                    onTap: () => _popThen(context, onMute),
                  ),
                ],
              ),
            ),
            Gaps.v10,

            // 섹션 2: Hide / Report
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondarySystemBackground(context),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.visibility_off,
                      color: AppColors.label(context),
                    ),
                    title: Text(
                      'Hide',
                      style: AppTextStyles.username(context),
                    ),
                    onTap: () => _popThen(context, onHide),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: AppColors.separator(context),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.flag,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Report',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () => _openReportSheet(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
