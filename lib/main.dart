import 'package:flutter/material.dart';
import 'package:insta_app/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaApp',
      home: LoginPage(),
    );
  }
}
