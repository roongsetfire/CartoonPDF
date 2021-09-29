import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roongpdf/utility/my_style.dart';
import 'package:roongpdf/widget/show_cartoon_list.dart';

import 'information_login.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String name, email;
  Widget currentWidget = ShowCartoonList();

  @override
  void initState() {
    super.initState();
    findNameAndEmail();
  }

  Future<Null> findNameAndEmail() async {
    await Firebase.initializeApp().then((value) {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Manga'),
        backgroundColor: MyStyle().primaryColor,
      ),
      drawer: buildDrawer(),
      onDrawerChanged: (isOpen) {
        findNameAndEmail();
      },
      body: currentWidget,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [DrawerHeader(), ListShowCartoon(), ListInformation()],
          ),
          signOut(),
        ],
      ),
    );
  }

  ListTile ListShowCartoon() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ShowCartoonList();
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.face,
        size: 40,
      ),
      title: Text('Show Cartoon List'),
      subtitle: Text('Show all cartoon in my stock'),
    );
  }

  ListTile ListInformation() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = Information();
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.perm_device_info,
        size: 40,
      ),
      title: Text('Information'),
      subtitle: Text('Information of User Login'),
    );
  }

  UserAccountsDrawerHeader DrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/space.jpg'), fit: BoxFit.fill)),
      accountName: MyStyle().titleH2White(name == null ? 'Name' : name),
      accountEmail: MyStyle().titleH3(email == null ? 'Email' : email),
      currentAccountPicture: Image.asset('images/logo.png'),
    );
  }

  Column signOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: MyStyle().darkColor,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 36,
          ),
          title: MyStyle().titleH2White('Sign out'),
          subtitle: MyStyle().titleH3White('Sign out & Go to Login'),
        ),
      ],
    );
  }
}
