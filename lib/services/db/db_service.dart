import 'dart:developer';

import 'package:botanicatch/models/badge_model.dart';
import 'package:botanicatch/models/plant_model.dart';
import 'package:botanicatch/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  static DatabaseService? _instance;

  factory DatabaseService({required String uid}) {
    if (_instance == null || _instance!.uid != uid) {
      _instance = DatabaseService._internal(uid: uid);
    }
    return _instance!;
  }

  DatabaseService._internal({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection(("users"));

  Future<void> updateUserData({String? username, String? email}) async {
    try {
      final Map<String, dynamic> updatedData = {};

      if (username != null) {
        updatedData['username'] = username;
      }

      if (email != null) {
        updatedData['email'] = email;
      }

      final docSnapshot = await userCollection.doc(uid).get();

      if (docSnapshot.exists) {
        return await userCollection.doc(uid).update(updatedData);
      } else {
        return await userCollection
            .doc(uid)
            .set(updatedData, SetOptions(merge: true));
      }
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Future<void> updateUserStats(Map<String, int> stats) async {
    try {
      await userCollection
          .doc(uid)
          .set({'stats': stats}, SetOptions(merge: true));
    } catch (e) {
      log("ERROR updating user stats: $e");
    }
  }

  Future<void> updateUserBadges(List<BadgeModel> badges) async {
    try {
      final List<Map<String, dynamic>> badgesJson =
          badges.map((badge) => badge.toJson()).toList();
      await userCollection
          .doc(uid)
          .set({'badges': badgesJson}, SetOptions(merge: true));
    } catch (e) {
      log("ERROR updating user badges: $e");
    }
  }

  UserModel _userModelFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};

    List<BadgeModel> badges = [];
    if (data['badges'] != null) {
      final badgesList = data['badges'] as List<dynamic>;
      badges = badgesList
          .map((badgeData) => BadgeModel.fromJson(badgeData))
          .toList();
    }

    Map<String, int> stats = {
      'totalPlantsDiscovered': 0,
      'uniquePlantsDiscovered': 0,
      'nativePlantsDiscovered': 0,
    };
    if (data['stats'] != null) {
      final statsData = data['stats'] as Map<String, dynamic>;
      statsData.forEach((key, value) {
        if (value is int) {
          stats[key] = value;
        }
      });
    }

    return UserModel(
      uid: uid,
      username: data["username"] ?? "Guest",
      email: data["email"] ?? "",
      badges: badges,
      stats: stats,
    );
  }

  Stream<UserModel> get userModel {
    return userCollection.doc(uid).snapshots().map(_userModelFromSnapshot);
  }

  Future<void> addPlantData(PlantModel plant) async {
    try {
      final CollectionReference plantsRef =
          userCollection.doc(uid).collection('plants');
      final QuerySnapshot snapshot =
          await plantsRef.orderBy('plant_id', descending: true).limit(1).get();

      int nextId = 1;
      if (snapshot.docs.isNotEmpty) {
        final latestId = snapshot.docs.first.get('plant_id') as int? ?? 0;
        nextId = latestId + 1;
      }

      await plantsRef.add(PlantModel(
        scientificName: plant.scientificName,
        commonName: plant.commonName,
        family: plant.family,
        description: plant.description,
        type: plant.type,
        confidence: plant.confidence,
        plantId: nextId,
        imageURL: plant.imageURL,
      ).toJson());
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Stream<List<QueryDocumentSnapshot>> get plantsStreamDescending {
    return userCollection
        .doc(uid)
        .collection('plants')
        .orderBy('plant_id', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Stream<List<QueryDocumentSnapshot>> get plantsStreamAscending {
    return userCollection
        .doc(uid)
        .collection('plants')
        .orderBy('plant_id', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<List<PlantModel>> getAllPlants() async {
    try {
      final QuerySnapshot snapshot =
          await userCollection.doc(uid).collection('plants').get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PlantModel.fromJson(data);
      }).toList();
    } catch (e) {
      log("ERROR getting all plants: $e");
      return [];
    }
  }
}
