import 'package:evenlty_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static Future<UserModel?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await _getUserInfo(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      print("${e.code}");
      throw e.message ?? "Something Went Wrong";
    }
  }

  static register(String password, UserModel user) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      String uid = credential.user!.uid;
      user.uid = uid;
      await _addUser(user);
    } on FirebaseAuthException catch (e) {
      print("${e.code}");
      throw e.message ?? "Something Went Wrong";
    } catch (e) {
      print(e);
    }
  }

  static CollectionReference<UserModel> _getUserCollection() {
    CollectionReference<UserModel> users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        );
    return users;
  }

  static _addUser(UserModel user) async {
    CollectionReference<UserModel> userCollection = _getUserCollection();
    DocumentReference doc = userCollection.doc(user.uid);
    await doc.set(user);
  }

  static Future<UserModel?> _getUserInfo(String uid) async {
    CollectionReference<UserModel> userCollection = _getUserCollection();
    DocumentReference<UserModel> doc = userCollection.doc(uid);
    DocumentSnapshot<UserModel> snapShot = await doc.get();
    return snapShot.data();
  }
}
