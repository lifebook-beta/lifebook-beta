import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../shell/home_shell.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return snapshot.data == null ? const LoginScreen() : const HomeShell();
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  Future<void> login() async {
    setState(() => loading = true);
    try {
      await AuthService().signInWithGoogle();
      await UserService().ensureCurrentUser();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const LBLogo(size: 92),
                const SizedBox(height: 22),
                const Text('LifeBook Beta',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Connect • Share • Earn',
                    style: TextStyle(color: Colors.grey.shade400)),
                const SizedBox(height: 42),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: loading ? null : login,
                    icon: const Icon(Icons.g_mobiledata),
                    label: Text(loading ? 'Signing in...' : 'Continue with Google'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'By continuing, you agree to the LifeBook Beta Terms & Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: lbMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
