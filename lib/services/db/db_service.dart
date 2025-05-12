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
  }

  UserModel _userModelFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: uid,
      username: snapshot.get("username") ?? "Guest",
      email: snapshot.get("email") ?? "",
    );
  }

  Stream<UserModel> get userModel {
    return userCollection.doc(uid).snapshots().map(_userModelFromSnapshot);
  }

  Future<void> addPlantData(PlantModel plant) async {
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
    ).toJson());
  }

  Stream<List<QueryDocumentSnapshot>> get plantsStream {
    return userCollection
        .doc(uid)
        .collection('plants')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
