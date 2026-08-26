import 'package:flutter/material.dart';

void main() {
  runApp(const LifeBookBeta());
}

class LifeBookBeta extends StatelessWidget {
  const LifeBookBeta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LifeBook Beta',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF071525),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF287BEA),
          brightness: Brightness.dark,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    FriendsPage(),
    MessagesPage(),
    AlertsPage(),
    EarningPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF202127),
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        indicatorColor: const Color(0xFF3E4A69),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Friends',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.monetization_on_outlined),
            selectedIcon: Icon(Icons.monetization_on),
            label: 'Earning',
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// HOME
// ------------------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: const Color(0xFF071525),
          pinned: true,
          titleSpacing: 18,
          title: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'LB',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'LifeBook Beta',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, size: 29),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, size: 30),
            ),
          ],
        ),

        // Stories
        SliverToBoxAdapter(
          child: SizedBox(
            height: 145,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              scrollDirection: Axis.horizontal,
              children: const [
                StoryItem(title: 'Your Story'),
                StoryItem(title: 'Friends'),
                StoryItem(title: 'Creators'),
                StoryItem(title: 'Trending'),
                StoryItem(title: 'News'),
              ],
            ),
          ),
        ),

        // Create post
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(18, 8, 18, 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF112A45),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFF31558F),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    "What's on your mind?",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white70,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 29,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Posts
        const SliverToBoxAdapter(
          child: PostCard(
            username: 'Sahad Sarkar',
            text: 'Enjoying the beautiful nature!',
            imageIcon: Icons.landscape,
          ),
        ),

        const SliverToBoxAdapter(
          child: PostCard(
            username: 'LifeBook Beta',
            text: 'Welcome to the new social experience.',
            imageIcon: Icons.public,
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// STORY
// ------------------------------------------------------------

class StoryItem extends StatelessWidget {
  final String title;

  const StoryItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105,
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0D3770),
            ),
            child: const Icon(
              Icons.person,
              size: 38,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// POST
// ------------------------------------------------------------

class PostCard extends StatelessWidget {
  final String username;
  final String text;
  final IconData imageIcon;

  const PostCard({
    super.key,
    required this.username,
    required this.text,
    required this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF112A45),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 29,
                backgroundColor: Color(0xFF31558F),
                child: Icon(
                  Icons.person,
                  size: 31,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  username,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            height: 245,
            decoration: BoxDecoration(
              color: const Color(0xFF153A62),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Icon(
                imageIcon,
                size: 75,
                color: const Color(0xFF2381F5),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PostButton(
                icon: Icons.thumb_up_alt_outlined,
                text: 'Like',
                onTap: () {},
              ),
              PostButton(
                icon: Icons.comment_outlined,
                text: 'Comment',
                onTap: () {},
              ),
              PostButton(
                icon: Icons.share_outlined,
                text: 'Share',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const PostButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFAFC8FF),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFAFC8FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// FRIENDS
// ------------------------------------------------------------

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'Friends',
      icon: Icons.people,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: const [
          FriendTile(name: 'Alex Johnson'),
          FriendTile(name: 'Rahim Ahmed'),
          FriendTile(name: 'Nadia Khan'),
          FriendTile(name: 'Tanvir Hasan'),
        ],
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  final String name;

  const FriendTile({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF112A45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFF31558F),
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// MESSAGES
// ------------------------------------------------------------

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'Messages',
      icon: Icons.chat,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: const [
          MessageTile(
            name: 'Alex Johnson',
            message: 'Hey! How are you?',
          ),
          MessageTile(
            name: 'Rahim Ahmed',
            message: 'Nice post!',
          ),
          MessageTile(
            name: 'Nadia Khan',
            message: 'See you tomorrow.',
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String name;
  final String message;

  const MessageTile({
    super.key,
    required this.name,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      leading: const CircleAvatar(
        radius: 27,
        backgroundColor: Color(0xFF31558F),
        child: Icon(Icons.person),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(message),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

// ------------------------------------------------------------
// ALERTS
// ------------------------------------------------------------

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'Alerts',
      icon: Icons.notifications,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: const [
          AlertTile(
            title: 'New friend request',
            subtitle: 'You have a new friend request.',
          ),
          AlertTile(
            title: 'Post liked',
            subtitle: 'Someone liked your post.',
          ),
          AlertTile(
            title: 'Welcome to LifeBook',
            subtitle: 'Thanks for joining LifeBook Beta.',
          ),
        ],
      ),
    );
  }
}

class AlertTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const AlertTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF112A45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF31558F),
            child: Icon(Icons.notifications),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// EARNING
// ------------------------------------------------------------

class EarningPage extends StatelessWidget {
  const EarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'Earning',
      icon: Icons.monetization_on,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF112A45),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 65,
                    color: Color(0xFF2381F5),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Your Balance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '৳ 0.00',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Start Earning',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------
// SIMPLE PAGE
// ------------------------------------------------------------

class SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const SimplePage({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: const Color(0xFF4B91FF),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
