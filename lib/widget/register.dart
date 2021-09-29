import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roongpdf/utility/dialog.dart';
import 'package:roongpdf/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screen;
  String name, user, password;

  Container buildName() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white54),
        width: screen * 0.75,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => name = value.trim(),
          style: TextStyle(color: MyStyle().darkColor),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: MyStyle().darkColor),
            hintText: 'Name',
            prefixIcon: Icon(
              Icons.fingerprint,
              color: MyStyle().darkColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: MyStyle().darkColor,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: MyStyle().lightColor,
                )),
          ),
        ));
  }

  Container buildUser() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white54),
        width: screen * 0.75,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => user = value.trim(),
          style: TextStyle(color: MyStyle().darkColor),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: MyStyle().darkColor),
            hintText: 'Username',
            prefixIcon: Icon(
              Icons.perm_identity,
              color: MyStyle().darkColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: MyStyle().darkColor,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: MyStyle().lightColor,
                )),
          ),
        ));
  }

  Container buildPassword() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white54),
        width: screen * 0.75,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => password = value.trim(),
          style: TextStyle(color: MyStyle().darkColor),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: MyStyle().darkColor),
            hintText: 'Password',
            prefixIcon: Icon(
              Icons.lock_outline,
              color: MyStyle().darkColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: MyStyle().darkColor,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: MyStyle().lightColor,
                )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: buildfloatbutton(),
      appBar: AppBar(
        backgroundColor: MyStyle().lightColor,
        title: Text('New Register'),
      ),
      body: Center(
        child: Column(
          children: [buildName(), buildUser(), buildPassword()],
        ),
      ),
    );
  }

  FloatingActionButton buildfloatbutton() {
    return FloatingActionButton(
      backgroundColor: MyStyle().primaryColor,
      onPressed: () {
        print('name = $name');
        print('user = $user');
        print('password = $password');
        if ((name?.isEmpty ?? true) ||
            (user?.isEmpty ?? true) ||
            (password?.isEmpty ?? true)) {
          print('Have Space');
          normalDialog(context, 'Have space? Please fill every blank.');
        } else {
          print('No Space');
          registerFirebase();
        }
      },
      child: Icon(Icons.cloud_upload_rounded),
    );
  }

  Future<Null> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('firebase Initialize Success');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        print('# Register Success #');
        await value.user.updateDisplayName(name).then((value) =>
            Navigator.pushNamedAndRemoveUntil(
                context, '/myService', (route) => false));
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }
}
