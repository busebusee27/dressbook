import 'package:dressbook/constants.dart';
import 'package:dressbook/services/app_state.dart';
import 'package:dressbook/views/dress_book.dart';
import 'package:dressbook/views/sign_in.dart';
import 'package:dressbook/views/splash_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppState appState = AppState();
  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DressBook',
      theme: appTheme,
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/home', page: () => const DressBookScreen()),
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(
          name: '/sign-in',
          page: () => const LogInScreen(),
        ),
      ],
    );
  }
}
