import 'package:flutter/material.dart';
// import 'package:order_master/view/new.dart';
import 'view/login.dart';

void main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login()
    );
  }
}
