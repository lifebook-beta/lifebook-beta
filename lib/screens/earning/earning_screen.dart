import 'package:flutter/material.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const followers = 0;
    const views = 0;

    final followerProgress = followers / 10000;
    final viewProgress = views / 100000;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const Text('Earning', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Monetization Status', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  const Text('Not eligible yet'),
                  const SizedBox(height: 18),
                  _progress('Followers', followers, 10000, followerProgress),
                  const SizedBox(height: 16),
                  _progress('Organic video views', views, 100000, viewProgress),
                  const SizedBox(height: 16),
                  const Text('Criteria: 10,000 followers + 100,000 organic views on at least one video. Final eligibility is verified server-side.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progress(String title, int value, int target, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title  $value / $target'),
        const SizedBox(height: 7),
        LinearProgressIndicator(value: progress.clamp(0, 1)),
      ],
    );
  }
}
