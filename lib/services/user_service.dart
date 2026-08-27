import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user.dart';

class UserService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  Future<void> ensureCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final ref = _users.doc(user.uid);
    final snapshot = await ref.get();

    if (!snapshot.exists) {
      final appUser = AppUser(
        id: user.uid,
        name: user.displayName ?? 'LifeBook User',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
      );
      await ref.set(appUser.toMap());
    }
  }

  Stream<AppUser?> currentUserStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _users.doc(uid).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return AppUser.fromMap(doc.id, doc.data()!);
    });
  }

  Future<AppUser?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists || doc.data() == null) return null;
    return AppUser.fromMap(doc.id, doc.data()!);
  }

  Future<void> updateProfile({
    required String name,
    required String bio,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('Not signed in');

    await _users.doc(uid).update({
      'name': name.trim(),
      'bio': bio.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
