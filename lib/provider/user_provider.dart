import 'package:evenlty_app/models/user_model.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;

  void setUser(UserModel user) {
    userModel = user;
    notifyListeners();
  }

  void logout() {
    userModel = null;
    notifyListeners();
  }
}
