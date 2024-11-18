import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String username;
  final String text;
  final String imageUrl;
  final DateTime timestamp;
  final List<String> likes; // uids of person who like this post.

  Post({
    required this.id,
    required this.userId,
    required this.username,
    required this.text,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
  });

  Post copyWith({String? imageUrl}) {
    return Post(
      id: id,
      userId: userId,
      username: username,
      text: text,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp,
      likes: likes,
    );
  }

  // convert post -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'likes': likes
    };
  }

// convert json -> post
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        userId: json['userId'],
        username: json['username'],
        text: json['text'],
        imageUrl: json['imageUrl'],
        timestamp: (json['timestamp'] as Timestamp).toDate(),
        likes: json['likes'] ?? []);
  }
}
