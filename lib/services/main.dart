import 'package:flutter/material.dart';
import 'package:ia/pages/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News Compiled",
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashPage(),
    );
  }
}
