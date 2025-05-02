class UserModel {
  final String? uid;
  final String? email;
  final String? username;
  const UserModel({
    required this.uid,
    required this.email,
    this.username,
  });
}
