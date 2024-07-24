import 'dart:ui';
import 'package:flutter/material.dart';

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

// Dimensions in physical pixels (px)
Size screenSize = view.physicalSize / view.devicePixelRatio;
double SCREEN_WIDTH = screenSize.width;
double SCREEN_HEIGHT = screenSize.height;

Color themeColor = Colors.purple;
ColorScheme colorScheme =
    ColorScheme.fromSeed(seedColor: themeColor, brightness: Brightness.dark);
ThemeData appTheme = ThemeData(colorScheme: colorScheme);
