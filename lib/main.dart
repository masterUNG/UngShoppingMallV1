import 'package:flutter/material.dart';
import 'package:ungshoppingmall/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Ung ShoppingMall',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Home(),
    );
  }
}
