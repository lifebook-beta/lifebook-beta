import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Post'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Your profile'),
            subtitle: Text('Public'),
          ),
          TextField(
            controller: controller,
            minLines: 5,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: "What's on your mind?",
            ),
          ),
          const SizedBox(height: 12),
          _action(Icons.photo_library_outlined, 'Photo / Video'),
          _action(Icons.emoji_emotions_outlined, 'Feeling / Activity'),
          _action(Icons.location_on_outlined, 'Check In'),
          _action(Icons.person_add_alt_1_outlined, 'Tag Friends'),
        ],
      ),
    );
  }

  Widget _action(IconData icon, String text) => ListTile(
    leading: Icon(icon),
    title: Text(text),
    onTap: () {},
  );
}
