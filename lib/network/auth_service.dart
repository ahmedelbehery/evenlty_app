// ignore_for_file: unused_local_variable

import 'package:evenlty_app/models/event_model.dart';
import 'package:evenlty_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<UserModel?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await getUserInfo();
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

  static Future<UserModel?> getUserInfo() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    CollectionReference<UserModel> userCollection = _getUserCollection();
    DocumentReference<UserModel> doc = userCollection.doc(uid);
    DocumentSnapshot<UserModel> snapShot = await doc.get();
    await getFavEvents();
    UserModel? user = await snapShot.data();
    if (user != null) {
      List<EventModel> events = await getFavEvents();
      user.favEvents = events;
      return user;
    }
    return null;
  }

  static CollectionReference<EventModel> _getUserFavEvents() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference<EventModel> collection = _getUserCollection()
        .doc(uid)
        .collection("fav events")
        .withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
    return collection;
  }

  static Future<List<EventModel>> getFavEvents() async {
    CollectionReference<EventModel> collection = _getUserFavEvents();
    QuerySnapshot<EventModel> snapshot = await collection.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Future<void> addFavEvent(EventModel event) async {
    CollectionReference<EventModel> collection = _getUserFavEvents();
    DocumentReference doc = collection.doc(event.id);
    await doc.set(event);
  }

  static Future<void> removeFavEvent(String id) async {
    CollectionReference<EventModel> collection = _getUserFavEvents();
    await collection.doc(id).delete();
  }

  static final GoogleSignIn _google = GoogleSignIn();
  static bool isInitialize = false;

  static Future<void> _initSignIn() async {
    if (!isInitialize) {
      await _google.signOut();
      isInitialize = true;
    }
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      await _initSignIn();
      final GoogleSignInAccount? googleUser = await _google.signIn();
      print("googleUser: $googleUser");
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (!userDoc.exists) {
          await _addUser(UserModel(
            uid: user.uid,
            email: user.email ?? "",
            name: user.displayName ?? "",
          ));
        }
      }
      return userCredential;
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }
}
