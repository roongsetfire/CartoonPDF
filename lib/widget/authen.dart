import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roongpdf/utility/dialog.dart';
import 'package:roongpdf/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen;
  bool statusRedEye = true;
  String user, password;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    print('screen = $screen');
    return Scaffold(
      floatingActionButton: buildRegister(),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                center: Alignment(0, -0.3),
                radius: 0.7,
                colors: <Color>[Colors.white, MyStyle().lightColor])),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildLogo(),
                MyStyle().titleH1('PDF BOOK'),
                buildUser(),
                buildPassword(),
                buildLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildRegister() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: Text(
        'New Register',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildLogin() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        width: screen * 0.75,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: MyStyle().darkColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                normalDialog(context, 'Have Space? Please fill every blank');
              } else {
                checkAuthen();
              }
            },
            child: Text('Login')));
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
            color: Colors.white54, borderRadius: BorderRadius.circular(20)),
        width: screen * 0.75,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: statusRedEye,
          style: TextStyle(color: MyStyle().darkColor),
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                },
                icon: statusRedEye
                    ? Icon(Icons.remove_red_eye)
                    : Icon(Icons.remove_red_eye_outlined)),
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

  Container buildLogo() {
    return Container(width: screen * 0.4, child: MyStyle().showlogo());
  }

  Future checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/myService', (route) => false))
          .catchError((value) => normalDialog(context, value.message));
    });
  }
}
