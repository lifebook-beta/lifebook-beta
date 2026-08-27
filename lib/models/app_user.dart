class AppUser {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String bio;
  final int friendCount;
  final int followerCount;
  final int followingCount;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl = '',
    this.bio = '',
    this.friendCount = 0,
    this.followerCount = 0,
    this.followingCount = 0,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
    'bio': bio,
    'friendCount': friendCount,
    'followerCount': followerCount,
    'followingCount': followingCount,
    'createdAt': DateTime.now().toUtc(),
  };

  factory AppUser.fromMap(String id, Map<String, dynamic> map) => AppUser(
    id: id,
    name: (map['name'] ?? '') as String,
    email: (map['email'] ?? '') as String,
    photoUrl: (map['photoUrl'] ?? '') as String,
    bio: (map['bio'] ?? '') as String,
    friendCount: (map['friendCount'] ?? 0) as int,
    followerCount: (map['followerCount'] ?? 0) as int,
    followingCount: (map['followingCount'] ?? 0) as int,
  );
}
