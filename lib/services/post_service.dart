import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> feedStream() {
    return _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(30)
        .snapshots();
  }

  Future<void> createTextPost(String text) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('Not signed in');

    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    await _db.collection('posts').add({
      'authorId': uid,
      'text': trimmed,
      'mediaUrl': '',
      'mediaType': '',
      'likeCount': 0,
      'commentCount': 0,
      'shareCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
