import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads/widgets/follow_button.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_data.dart';
import '../../constants/gaps.dart';
import '../../constants/text_style.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController =
      TextEditingController();
  List<UserProfile> _filteredUsers = [];
  List<UserProfile> _allUsers = [];

  @override
  void initState() {
    super.initState();
    _allUsers = SearchData.generateUsers();
    _filteredUsers = List.from(_allUsers);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredUsers = List.from(_allUsers);
      } else {
        _filteredUsers = _allUsers.where((user) {
          return user.username.toLowerCase().contains(query) ||
              user.displayName.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.systemBackground(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ScreenHeader(),
            _SearchField(controller: _searchController),
            Gaps.v20,
            _UserList(users: _filteredUsers),
          ],
        ),
      ),
    );
  }
}

class _ScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Search',
        style: AppTextStyles.screenTitle(context),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;

  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CupertinoSearchTextField(
        controller: controller,
        placeholder: 'Search',
        style: AppTextStyles.common(context),
        decoration: BoxDecoration(
          color: AppColors.secondarySystemBackground(context),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  final List<UserProfile> users;

  const _UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) =>
            _UserTile(user: users[index]),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final UserProfile user;

  const _UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: _UserAvatar(user: user),
          title: _UserInfo(user: user),
          trailing: FollowButton(
            onPressed: () {
              debugPrint('${user.username} 팔로우 상태 변경');
            },
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.separator(context),
          indent: 60, // leading 영역만큼 들여쓰기
        ),
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final UserProfile user;

  const _UserAvatar({required this.user});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: user.avatarUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: AppColors.secondarySystemBackground(context),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: const Color(0xFFE3F2FD),
            child: Icon(
              Icons.person,
              color: AppColors.systemBackground(context),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final UserProfile user;

  const _UserInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UsernameRow(user: user),
        Gaps.v2,
        Text(
          user.displayName,
          style: AppTextStyles.userIntroduction(context),
        ),
        Gaps.v6,
        Text(
          '${user.followers} followers',
          style: AppTextStyles.common(context),
        ),
      ],
    );
  }
}

class _UsernameRow extends StatelessWidget {
  final UserProfile user;

  const _UsernameRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(user.username, style: AppTextStyles.username(context)),
        if (user.isVerified) ...[
          Gaps.h4,
          Icon(Icons.verified, size: 14, color: Colors.blue),
        ],
      ],
    );
  }
}
