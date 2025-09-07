import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String username;
  final bool isVerified;
  final String timeAgo;
  final String text;
  final List<String> imageUrls;
  final int replies;
  final int likes;
  final List<String> likedByAvatars;
  final String avatarUrl;

  PostModel({
    required this.username,
    required this.isVerified,
    required this.timeAgo,
    required this.text,
    required this.imageUrls,
    required this.replies,
    required this.likes,
    required this.likedByAvatars,
    required this.avatarUrl,
  });

  factory PostModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final m = doc.data() ?? {};
    final ts = m['createdAt'];
    final dt = ts is Timestamp ? ts.toDate() : null;

    return PostModel(
      username: (m['username'] ?? 'user') as String,
      isVerified: (m['isVerified'] ?? false) as bool,
      timeAgo: formatTimeAgo(dt),
      text: (m['text'] ?? (m['content'] ?? '')) as String,
      imageUrls: List<String>.from(m['imageUrls'] ?? []),
      replies: ((m['replies'] ?? m['comments'] ?? 0) as num).toInt(),
      likes: ((m['likes'] ?? 0) as num).toInt(),
      likedByAvatars: List<String>.from(m['likedByAvatars'] ?? []),
      avatarUrl: (m['avatarUrl'] ?? '') as String,
    );
  }
}

String formatTimeAgo(DateTime? t) {
  if (t == null) return 'now';
  final d = DateTime.now().difference(t);
  if (d.inMinutes < 1) return 'now';
  if (d.inMinutes < 60) return '${d.inMinutes}m';
  if (d.inHours < 24) return '${d.inHours}h';
  return '${d.inDays}d';
}
