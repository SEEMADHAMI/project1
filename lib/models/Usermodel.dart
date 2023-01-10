class UserModel {
  late String uid;

  late String email;

  late String name;

  late String profileImage;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profileImage': profileImage,
    };
  }
}
