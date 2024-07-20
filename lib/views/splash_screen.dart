import 'dart:async';

import 'package:dressbook/views/dress_book.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState(); 
    Timer(const Duration(seconds: 3), 
          () => Get.off(() => const DressBookScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      color: Colors.amber, 
      child:FlutterLogo(size:MediaQuery.of(context).size.height) 
    ); 
  }
}