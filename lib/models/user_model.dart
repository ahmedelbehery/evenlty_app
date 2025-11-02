import 'package:evenlty_app/models/event_model.dart';

class UserModel {
  String name;
  String email;
  String? uid;
  List<EventModel>? favEvents;
  UserModel({required this.name, required this.email, this.uid,this.favEvents});
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
