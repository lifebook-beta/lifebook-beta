import 'package:flutter/material.dart';
import '../shell/home_shell.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const SectionTitle(title: 'Friends'),
          const Text('Maximum friends: 1,000'),
          const SizedBox(height: 14),
          TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search friends')),
          const SizedBox(height: 12),
          ...List.generate(8, (i) => Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(['Anika Islam','Rafi Ahmed','Mehedi Hasan','Nusrat Jahan','Tanvir Hossain','Samiul Karim','Mitu Akter','Arif Hasan'][i]),
              subtitle: Text('${50 + i * 20} mutual friends'),
              trailing: FilledButton(onPressed: () {}, child: const Text('Friends')),
            ),
          )),
        ],
      ),
    );
  }
}
