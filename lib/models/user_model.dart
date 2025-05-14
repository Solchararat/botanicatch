import 'package:botanicatch/models/badge_model.dart';

class UserModel {
  final String? uid;
  final String? username;
  final String? email;
  final List<BadgeModel> badges;
  final Map<String, int> stats;

  UserModel({
    this.uid,
    this.username,
    this.email,
    List<BadgeModel>? badges,
    Map<String, int>? stats,
  })  : badges = badges ?? [],
        stats = stats ??
            {
              'totalPlantsDiscovered': 0,
              'uniquePlantsDiscovered': 0,
              'nativePlantsDiscovered': 0,
            };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<BadgeModel> badges = [];
    if (json['badges'] != null) {
      badges = (json['badges'] as List)
          .map((badge) => BadgeModel.fromJson(badge))
          .toList();
    }

    Map<String, int> stats = {
      'totalPlantsDiscovered': 0,
      'uniquePlantsDiscovered': 0,
      'nativePlantsDiscovered': 0,
    };
    if (json['stats'] != null) {
      json['stats'].forEach((key, value) {
        if (value is int) {
          stats[key] = value;
        }
      });
    }

    return UserModel(
      uid: json['uid'],
      username: json['username'],
      email: json['email'],
      badges: badges,
      stats: stats,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'badges': badges.map((badge) => badge.toJson()).toList(),
      'stats': stats,
    };
  }

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    List<BadgeModel>? badges,
    Map<String, int>? stats,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      badges: badges ?? List.from(this.badges),
      stats: stats ?? Map.from(this.stats),
    );
  }
}
