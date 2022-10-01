import 'package:flutter/material.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/modules/home/components/item.dart';
import 'package:pbl6/modules/register/register.dart';

import 'modules/home/home.dart';
import 'modules/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PBl6',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch:Colors.blue,
        scaffoldBackgroundColor:DarkTheme.darkBackground,
        textTheme:Theme.of(context).textTheme.apply(
          bodyColor:Colors.white,
          displayColor:Colors.white
        )
      ),
      home: Home(),
    );
  }
}
