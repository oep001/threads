import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, String>> _allActivities = [];
  List<Map<String, String>> _filteredActivities = [];

  static const _tabs = ['All', 'Replies', 'Mentions', 'Verified'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    // 더미 데이터 (UI 확인용)
    _allActivities = [
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'alice',
        'content': 'replied to your post',
        'timeAgo': '2m',
        'description': 'Nice work!',
        'avatarUrl':
            'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'bob',
        'content': 'mentioned you',
        'timeAgo': '15m',
        'description': '@you check this out',
        'avatarUrl':
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&h=100&fit=crop&crop=faces',
      },
      {
        'username': 'carol',
        'content': 'followed you',
        'timeAgo': '1h',
        'description': '',
        'avatarUrl':
            'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=100&h=100&fit=crop&crop=faces',
      },
    ];
    _filteredActivities = List.from(_allActivities);
    _tabController.addListener(() {
      setState(() {
        _filteredActivities = List.from(_allActivities); // 일단 필터링 생략
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Activity',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _CustomTabBar(tabController: _tabController, tabs: _tabs),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredActivities.length,
                itemBuilder: (context, index) {
                  final activity = _filteredActivities[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        activity['avatarUrl']!,
                      ),
                      radius: 24,
                    ),
                    title: Text(activity['username']!),
                    subtitle: Text(activity['content']!),
                    trailing: Text(activity['timeAgo']!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  const _CustomTabBar({
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = tabController.index == index;
          return GestureDetector(
            onTap: () => tabController.animateTo(index),
            child: Container(
              width: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
