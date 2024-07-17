import 'dart:ui';
import 'package:flutter/material.dart';

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

// Dimensions in physical pixels (px)
Size screenSize = view.physicalSize / view.devicePixelRatio;
double SCREEN_WIDTH = screenSize.width;
double SCREEN_HEIGHT = screenSize.height;


Color themeColor = Colors.amber;
ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: themeColor);