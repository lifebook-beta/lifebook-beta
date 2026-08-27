import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ['Anika Islam liked your post.', 'Rafi Ahmed commented on your post.', 'Nusrat Jahan followed you.', 'Tanvir Hossain sent you a message.'];
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const Text('Notifications', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...items.map((x) => Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: Text(x), subtitle: const Text('Recently')))),
        ],
      ),
    );
  }
}
