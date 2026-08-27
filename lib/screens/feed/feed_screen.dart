import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../shell/home_shell.dart';
import '../create_post/create_post_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Row(children: const [LBLogo(size: 34), SizedBox(width: 10), Text('LifeBook Beta')]),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _stories(),
                  const SizedBox(height: 10),
                  _composer(context),
                  const SizedBox(height: 8),
                  _post('Sahad Sarkar', 'Enjoying the beautiful nature!', Icons.landscape),
                  _post('LifeBook Beta', 'Welcome to the new social experience.', Icons.public),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stories() {
    final names = ['Your Story', 'Friends', 'Creators', 'Trending', 'News'];
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: names.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => SizedBox(
          width: 70,
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: lbBlue.withOpacity(.25),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(names[i], overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }

  Widget _composer(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatePostScreen())),
        child: const Padding(
          padding: EdgeInsets.all(14),
          child: Row(children: [
            CircleAvatar(child: Icon(Icons.person)),
            SizedBox(width: 12),
            Expanded(child: Text("What's on your mind?")),
            Icon(Icons.photo_camera_outlined),
          ]),
        ),
      ),
    );
  }

  Widget _post(String name, String text, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const CircleAvatar(child: Icon(Icons.person)),
              const SizedBox(width: 10),
              Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700))),
              const Icon(Icons.more_horiz),
            ]),
            const SizedBox(height: 14),
            Text(text),
            const SizedBox(height: 14),
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: lbBlue.withOpacity(.13),
              ),
              child: Icon(icon, size: 70, color: lbBlue),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.thumb_up_outlined), label: const Text('Like')),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.comment_outlined), label: const Text('Comment')),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.share_outlined), label: const Text('Share')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
