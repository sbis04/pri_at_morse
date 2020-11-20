import 'package:flutter/material.dart';
import 'package:primorse/screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRI@morse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Goldman',
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
