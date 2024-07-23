import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:dressbook/firebase_options.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  late User? currentUser;
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        currentUser = user;
      } else {
        _loggedIn = false;
        currentUser = null;
      }
      notifyListeners();
    });
  }
}
