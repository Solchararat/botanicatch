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

  Future updateUserData({
    String? username,
    String? email,
  }) async {
    return await userCollection.doc(uid).set({
      "username": username,
      "email": email,
    });
  }

  UserModel _userModelFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: uid,
      username: snapshot.get("username") ?? "",
      email: snapshot.get("email") ?? "",
    );
  }

  Stream<UserModel> get userModel {
    return userCollection.doc(uid).snapshots().map(_userModelFromSnapshot);
  }
}
