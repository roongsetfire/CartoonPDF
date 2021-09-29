import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xff7e6339);
  Color primaryColor = Color(0xffaf9064);
  Color lightColor = Color(0xffefc589);

  String disPlayName;

  BoxDecoration boxDecoration() => BoxDecoration(
      color: Colors.white54, borderRadius: BorderRadius.circular(20));

  Widget showlogo() => Image.asset('images/logo.png');

  Widget titleH1(String string) => Text(
        string,
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: darkColor),
      );
  Widget titleH2(String string) => Text(
        string,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: darkColor),
      );
  Widget titleH2White(String string) => Text(
        string,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      );
  Widget titleH3(String string) => Text(
        string,
        style: TextStyle(fontSize: 16, color: darkColor),
      );
  Widget titleH3White(String string) => Text(
        string,
        style: TextStyle(fontSize: 16, color: Colors.white54),
      );
  MyStyle();
}
