import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/theme.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: StreamBuilder(
        stream: UserService().currentUserStream(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          final name = user?.name ?? authUser?.displayName ?? 'LifeBook User';
          final email = user?.email ?? authUser?.email ?? '';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Center(child: LBLogo(size: 86)),
              const SizedBox(height: 12),
              Center(
                child: Text(name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              ),
              Center(child: Text(email, style: const TextStyle(color: lbMuted))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _stat('Friends', '${user?.friendCount ?? 0}'),
                  _stat('Followers', '${user?.followerCount ?? 0}'),
                  _stat('Following', '${user?.followingCount ?? 0}'),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => _edit(context, name, user?.bio ?? ''),
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () async => AuthService().signOut(),
                child: const Text('Log out'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _stat(String title, String value) => Column(
    children: [
      Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      Text(title, style: const TextStyle(color: lbMuted)),
    ],
  );

  Future<void> _edit(BuildContext context, String name, String bio) async {
    final nameController = TextEditingController(text: name);
    final bioController = TextEditingController(text: bio);

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 10),
            TextField(controller: bioController, decoration: const InputDecoration(labelText: 'Bio')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              await UserService().updateProfile(
                name: nameController.text,
                bio: bioController.text,
              );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
