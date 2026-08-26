import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          return const HomePage();
        }

        return const LoginPage();
      },
    );
  }
}

// =========================
// LOGIN
// =========================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      showMessage('Email and password required.');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? 'Login failed.');
    } catch (e) {
      showMessage('Something went wrong.');
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 42,
                  child: Text(
                    'LB',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'LifeBook Beta',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Connect. Share. Discover.',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: loading ? null : login,
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text('Create a new account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================
// REGISTER
// =========================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showMessage('Please fill all fields.');
      return;
    }

    if (password.length < 6) {
      showMessage('Password must be at least 6 characters.');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await user.updateDisplayName(name);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? 'Registration failed.');
    } catch (e) {
      showMessage('Something went wrong.');
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: loading ? null : register,
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text('Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================
// HOME
// =========================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final pages = const [
    FeedPage(),
    FriendsPage(),
    MessagesPage(),
    AlertsPage(),
    EarningPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
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

// =========================
// FEED
// =========================

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text(
              'LifeBook Beta',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              user?.displayName != null
                                  ? 'Hello, ${user!.displayName}!'
                                  : "What's on your mind?",
                            ),
                          ),
                          const Icon(Icons.camera_alt_outlined),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const PostCard(
                    name: 'LifeBook Beta',
                    text: 'Welcome to the new social experience.',
                    icon: Icons.public,
                  ),
                  const PostCard(
                    name: 'LifeBook Beta',
                    text: 'Connect with friends and discover new creators.',
                    icon: Icons.people,
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

class PostCard extends StatelessWidget {
  final String name;
  final String text;
  final IconData icon;

  const PostCard({
    super.key,
    required this.name,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFF12345A),
              ),
              child: Icon(
                icon,
                size: 64,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('♡  Like'),
                Text('💬  Comment'),
                Text('↗  Share'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// OTHER PAGES
// =========================

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Friends',
        style: TextStyle(fontSize: 28),
      ),
    );
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Messages',
        style: TextStyle(fontSize: 28),
      ),
    );
  }
}

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Alerts',
        style: TextStyle(fontSize: 28),
      ),
    );
  }
}

class EarningPage extends StatelessWidget {
  const EarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Earning',
        style: TextStyle(fontSize: 28),
      ),
    );
  }
}
