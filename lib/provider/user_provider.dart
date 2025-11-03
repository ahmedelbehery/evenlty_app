import 'package:evenlty_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;

  void setUser(UserModel user) {
    userModel = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    userModel = null;
    notifyListeners();
  }
}
