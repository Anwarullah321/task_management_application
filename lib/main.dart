
import 'package:flutter/material.dart';
import 'package:task_management_application/Screens/sign_up.dart';
import 'package:task_management_application/Screens/todo_list.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //theme: ThemeData.dark(),
      home: const SignUpScreen(),

    );
  }
}