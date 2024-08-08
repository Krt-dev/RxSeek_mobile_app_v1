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

  UserModel? user;
  // SimulatedAPI api = SimulatedAPI();
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

  register(String email, String password) async {
    UserCredential? userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = UserModel(
        userId: userCredential.user?.uid as int,
        firstName: "Rhunnan",
        lastName: "Dwight",
        userName: "Rhunnan Dwight",
        email: "rhunnandwight@gmail.com",
        status: Status.user,
        profileUrl: "",
        joinedAt: Timestamp.now());
    notifyListeners();
    await db
        .collection("Users")
        .doc(userCredential.user?.uid)
        .set(user!.toJson());
  }

  login(String userName, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userName, password: password);
    notifyListeners();
  }

  ///write code to log out the user and add it to the home page.
  logout() async {
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
}
