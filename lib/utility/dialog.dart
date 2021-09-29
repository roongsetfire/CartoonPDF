import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roongpdf/utility/my_style.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: ListTile(
              leading: Image.asset('images/logo.png'),
              title: Text('Something incorrect',style: TextStyle(color: MyStyle().primaryColor,fontWeight: FontWeight.bold)),
              subtitle: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(string)),
            ),
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
          ));
}
