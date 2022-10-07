

import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTextStyle{
  static const heading1 =
  TextStyle(fontWeight: FontWeight.w400, fontSize: 30, height: 1.2);
  static const heading1SemiBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30,
  );
  static const heading1Medium = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30,
    height: 1.2,
  );

  //==========Heading 2=============
  static const heading2 = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24,
      height: 1.2,
      decoration: TextDecoration.none,
      color: DarkTheme.white);

  static const heading2Black = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 1.2,
      decoration: TextDecoration.none,
      color: Colors.black);

  //==========Heading 3=============
  static const heading3 = TextStyle(fontWeight: FontWeight.w500, fontSize: 20, height: 1.2);

  static const heading3Medium = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.2,
      decoration: TextDecoration.none,
      color: DarkTheme.white);

  static const heading3Light = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.2,
      color: DarkTheme.white,
      decoration: TextDecoration.none);

  static const heading3Red = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.2,
      color: DarkTheme.red,
      decoration: TextDecoration.none);

  static const heading3Black = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 1.2,
      color: Colors.black,
      decoration: TextDecoration.none);

  static const heading3Purple = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 1.2,
      color: DarkTheme.purple,
      decoration: TextDecoration.none);

  //==========Heading 4=============
  static const heading4 = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.2,
      decoration: TextDecoration.none,
      color: DarkTheme.white);

  static const heading4Light = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 1.2,
      color: DarkTheme.white,
      decoration: TextDecoration.none);
  static const heading4Black = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 1.2,
      color: Colors.black,
      decoration: TextDecoration.none);
  static const heading4Purple = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.2,
      color: Colors.purpleAccent,
      decoration: TextDecoration.none);
  static const h = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.0,
      color: DarkTheme.white,
      decoration: TextDecoration.none
  );
}
