import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxseek_v1/src/enum/enum.dart';
import 'package:rxseek_v1/src/models/user_model.dart';

class AuthController with ChangeNotifier {
  //get currentUser => null;

  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  // Static getter to access the instance through GetIt
  static AuthController get instance => GetIt.instance<AuthController>();

  static AuthController get I => GetIt.instance<AuthController>();

  AuthState state = AuthState.unauthenticated;
  FirebaseFirestore db = FirebaseFirestore.instance;

  UserModel? user; // SimulatedAPI api = SimulatedAPI();
  late StreamSubscription<User?> currentAuthedUser;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  AuthController() {
    listen();
  }

  listen() {
    currentAuthedUser =
        FirebaseAuth.instance.authStateChanges().listen(handleUserChanges);
  }

  void handleUserChanges(User? user) {
    if (user == null) {
      state = AuthState.unauthenticated;
    } else {
      state = AuthState.authenticated;
    }
    notifyListeners();
  }

  register(String email, String password, firstName, lastName, userName) async {
    UserCredential? userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = UserModel(
        userId: userCredential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        email: userCredential.user!.email.toString(),
        status: "user",
        profileUrl: "",
        joinedAt: Timestamp.now());
    notifyListeners();
    try {
      await db
          .collection("Users")
          .doc(userCredential.user?.uid)
          .set(user!.toJson());
    } on FirebaseAuthException catch (e) {
      print("${e.toString()}");
    }
  }

  login(String userName, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userName, password: password);
    var initialUserDoc =
        await db.collection("Users").doc(userCredential.user!.uid).get();
    user = UserModel.fromJson(initialUserDoc.data()!);
    notifyListeners();
  }

  ///write code to log out the user and add it to the home page.
  logout() async {
    user = null;
    notifyListeners();
    return await FirebaseAuth.instance.signOut();
  }

  ///must be called in main before runApp
  ///
  loadSession() async {
    listen();
    User? user = FirebaseAuth.instance.currentUser;
    handleUserChanges(user);
  }

  Future<UserModel> getUser(String uid) async {
    try {
      final docSnap = await db.collection("Users").doc(uid).get();
      if (docSnap.exists) {
        UserModel userInfo = UserModel.fromJson(docSnap.data()!);
        return userInfo;
      } else {
        throw Exception("Document Does not Exist");
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
