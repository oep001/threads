import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:threads/widgets/post_action_sheet.dart';

import '../constants/app_colors.dart';
import '../constants/gaps.dart';
import '../constants/text_style.dart';

class PostComponent extends StatefulWidget {
  const PostComponent({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.text,
    required this.replies,
    required this.likes,
    this.imageUrls = const <String>[],
    this.likedByAvatars = const <String>[],
    this.isVerified = false,
    this.avatarUrl,
  });

  final String username;
  final String timeAgo;
  final String text;
  final int replies;
  final int likes;
  final List<String> imageUrls;
  final List<String> likedByAvatars;
  final bool isVerified;
  final String? avatarUrl;

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _AvatarNetwork extends StatelessWidget {
  const _AvatarNetwork({required this.size, this.url});
  final double size;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final u = url?.trim();
    if (u == null || u.isEmpty) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipOval(
          child: Container(
            color: AppColors.secondarySystemBackground(context),
            child: Icon(
              Icons.person,
              color: AppColors.systemBackground(context),
              size: size * 0.6,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: u,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: AppColors.secondarySystemBackground(context),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: AppColors.secondarySystemBackground(context),
            child: Icon(
              Icons.person,
              color: AppColors.systemBackground(context),
              size: size * 0.6,
            ),
          ),
        ),
      ),
    );
  }
}

class _PostComponentState extends State<PostComponent> {
  bool isLiked = false;
  bool isCommented = false;
  bool isReposted = false;
  bool isShared = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 좌측 섹션
              Column(
                children: [
                  // 프로필 이미지
                  _AvatarNetwork(size: 36, url: widget.avatarUrl),
                  Gaps.v8,
                  // 세로선
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.separator(context),
                    ),
                  ),
                  Gaps.v8,
                  // 아바타 이미지
                  _MiniAvatarStack(urls: widget.likedByAvatars),
                ],
              ),
              Gaps.h12,
              Expanded(
                // 우측 섹션
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v4,
                    // 유저 네임 / 인증 마크 / 시간 / ... 버튼
                    Row(
                      children: [
                        //유저 네임
                        Text(
                          widget.username,
                          style: AppTextStyles.username(context),
                        ),
                        // 인증 마크
                        if (widget.isVerified) ...[
                          Gaps.h4,
                          Icon(
                            Icons.verified,
                            size: 16,
                            color: AppColors.accent(context),
                          ),
                        ],
                        const Spacer(),
                        // 시간
                        Text(
                          widget.timeAgo,
                          style: AppTextStyles.system(context),
                        ),
                        Gaps.h12,
                        // ... 버튼
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor:
                                  AppColors.systemBackground(context),
                              context: context,
                              builder: (context) => PostActionSheet(),
                            );
                          },
                          child: Icon(
                            Icons.more_horiz,
                            size: 18,
                            color: AppColors.tertiaryLabel(context),
                          ),
                        ),
                      ],
                    ),
                    Gaps.v4,
                    Text(
                      widget.text,
                      style: AppTextStyles.common(context),
                    ),
                    if (widget.imageUrls.isNotEmpty) ...[
                      Gaps.v12,
                      _MediaGallery(urls: widget.imageUrls),
                    ],
                    Gaps.v16,
                    Row(
                      children: [
                        _ActionIcon(
                          icon: isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          onTap: () =>
                              setState(() => isLiked = !isLiked),
                          isSelected: isLiked,
                          selectedColor: Colors.red,
                        ),
                        Gaps.h5,
                        _ActionIcon(
                          icon: Icons.mode_comment_outlined,
                          onTap: () => setState(
                            () => isCommented = !isCommented,
                          ),
                          isSelected: isCommented,
                          selectedColor: Colors.orange,
                        ),
                        Gaps.h5,
                        _ActionIcon(
                          icon: Icons.repeat,
                          onTap: () => setState(
                            () => isReposted = !isReposted,
                          ),
                          isSelected: isReposted,
                          selectedColor: Colors.green,
                        ),
                        Gaps.h5,
                        _ActionIcon(
                          icon: Icons.send_outlined,
                          onTap: () =>
                              setState(() => isShared = !isShared),
                          isSelected: isShared,
                        ),
                      ],
                    ),
                    Gaps.v12,
                    Text(
                      '${widget.replies} replies · ${widget.likes} likes',
                      style: AppTextStyles.system(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.onTap,
    this.isSelected = false,
    this.selectedColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final color = selectedColor ?? AppColors.accent(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? color.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected
              ? color
              : AppColors.secondaryLabel(context),
        ),
      ),
    );
  }
}

class _MiniAvatarStack extends StatelessWidget {
  const _MiniAvatarStack({required this.urls});
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) {
      return const SizedBox(width: 24, height: 24);
    }
    final n = urls.length.clamp(0, 3);
    return SizedBox(
      width: 24 + (n > 1 ? (n - 1) * 12 : 0),
      height: 24,
      child: Stack(
        children: [
          for (int i = 0; i < n; i++)
            Positioned(
              left: i * 12,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.systemBackground(context),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.label(
                        context,
                      ).withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: urls[i],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.secondarySystemBackground(
                        context,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MediaGallery extends StatelessWidget {
  const _MediaGallery({required this.urls});
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    final display = urls.take(3).toList();
    if (display.isEmpty) return const SizedBox.shrink();

    final screenW = MediaQuery.of(context).size.width;
    final baseWidth = screenW - (16 * 2) - 36 - 12;

    return _buildImageLayout(display, baseWidth);
  }

  Widget _buildImageLayout(List<String> images, double maxWidth) {
    if (images.length == 1) {
      return _buildSingleImage(images[0], maxWidth);
    } else {
      return _buildMultipleImages(images, maxWidth);
    }
  }

  Widget _buildSingleImage(String imageUrl, double maxWidth) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: maxWidth,
        height: 200,
        child: _buildCachedImage(imageUrl),
      ),
    );
  }

  Widget _buildMultipleImages(List<String> images, double maxWidth) {
    return SizedBox(
      height: 200,
      width: maxWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            width: maxWidth * 0.9,
            margin: EdgeInsets.only(
              right: index < images.length - 1 ? 8 : 0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildCachedImage(images[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCachedImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.secondarySystemBackground(context),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.secondarySystemBackground(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image_outlined,
                size: 32,
                color: AppColors.quaternaryLabel(context),
              ),
              Gaps.v4,
              Text(
                '이미지 로드 실패',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.tertiaryLabel(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
