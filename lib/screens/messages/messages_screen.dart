import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const Text('Messages', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          const TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search messages')),
          const SizedBox(height: 12),
          ...['Anika Islam','Rafi Ahmed','Mehedi Hasan','Nusrat Jahan','Tanvir Hossain'].map(
            (name) => Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(name),
                subtitle: const Text('Tap to open chat'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(name: name))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String name;
  const ChatScreen({super.key, required this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final messages = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (_, i) => Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(messages[i]),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
                  Expanded(child: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Type a message...'))),
                  IconButton(
                    onPressed: () {
                      if (controller.text.trim().isEmpty) return;
                      setState(() {
                        messages.add(controller.text.trim());
                        controller.clear();
                      });
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
