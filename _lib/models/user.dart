import 'user_preference.dart';
import 'user_subscription.dart';

class User {
  final String id;
  final String email;
  final String fullName;
  final String? photoUrl;
  final String? bio;
  final UserPreferences preferences;
  final UserSubscription subscription;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    this.photoUrl,
    this.bio,
    required this.preferences,
    required this.subscription,
    required this.createdAt,
    this.lastLoginAt,
  });

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? photoUrl,
    String? bio,
    UserPreferences? preferences,
    UserSubscription? subscription,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      preferences: preferences ?? this.preferences,
      subscription: subscription ?? this.subscription,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'photoUrl': photoUrl,
      'bio': bio,
      'preferences': preferences.toJson(),
      'subscription': subscription.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      photoUrl: json['photoUrl'],
      bio: json['bio'],
      preferences: UserPreferences.fromJson(json['preferences']),
      subscription: UserSubscription.fromJson(json['subscription']),
      createdAt: DateTime.parse(json['createdAt']),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'])
          : null,
    );
  }
}