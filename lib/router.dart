import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/activity_screen.dart';
import '../views/app_shell.dart';
import '../views/post_screen.dart';
import '../views/privacy_screen.dart';
import '../views/profile_screen.dart';
import '../views/search_screen.dart';
import '../views/settings_screen.dart';

// 루트 네비게이터(셸 밖 화면: 설정 등)
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const PostScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/activity',
              builder: (context, state) => const ActivityScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),

    // Settings routes outside of shell (full screen)
    GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsScreen(),
      routes: [
        GoRoute(path: 'privacy', builder: (_, __) => const PrivacyScreen()),
      ],
    ),
  ],
);
