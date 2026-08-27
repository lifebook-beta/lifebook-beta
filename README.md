# LifeBook Beta 🔥

A Flutter + Firebase starter architecture for the LifeBook Beta social platform.

## Current MVP scope
- Google/Gmail sign-in via Firebase Authentication
- LB-only branding
- Home feed
- Create post
- Friends with a hard 1,000-friend limit
- Followers/following counters
- In-app text messaging (no audio/video calls in Beta)
- Notifications
- Monetization eligibility dashboard
- Dark navy + blue visual system matching the supplied UI reference

## Before running
1. Install Flutter.
2. Create a Firebase project.
3. Enable Google provider in Firebase Authentication.
4. Add Android/iOS apps to Firebase.
5. Run `flutterfire configure` in this project to generate `lib/firebase_options.dart`.
6. Run `flutter pub get`.
7. Run `flutter run`.

## Important
Never put Firebase Admin credentials, private keys, or server secrets in the Flutter client.
Monetization eligibility must be verified server-side. The 100,000-view requirement should use organic/fraud-reviewed view data, not a client-controlled counter.
