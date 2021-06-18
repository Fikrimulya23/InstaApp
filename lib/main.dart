import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/pages/bottom_navigation.dart';
import 'package:insta_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaApp',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;
          if (user != null) {
            print('akun masuk');
            return BottomNavigation();
          } else {
            print('akun belum masuk');
            return LoginPage();
          }
        },
      ),
    );
  }
}
