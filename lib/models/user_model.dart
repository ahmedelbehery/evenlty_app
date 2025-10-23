class UserModel {
  String name;
  String email;
  String? uid;
  UserModel({required this.name, required this.email, this.uid});
  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "uid": uid};
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      uid: json["uid"],
    );
  }
}
