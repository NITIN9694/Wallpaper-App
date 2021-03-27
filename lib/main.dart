import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallpaper/Screen/HomeScreem.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
        ..maxConnectionsPerHost = 5;
  }
}
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home:HomeScreen()
    );
  }
}