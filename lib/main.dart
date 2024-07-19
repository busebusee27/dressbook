import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dressbook/constants.dart';
import 'package:dressbook/firebase_options.dart';
import 'package:dressbook/views/dress_book.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'DressBook',
        theme: ThemeData(
          useMaterial3: false,
          colorScheme: colorScheme
        ),
        home: const DressBookScreen(),
      );
  }
}