import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roongpdf/utility/my_style.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  String displayName;

  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<Null> findDisplayName() async {
    await Firebase.initializeApp().then((value) {
      FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          displayName = event.displayName;
        });
        print('displayName = $displayName');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 300,
        child: ListTile(
          trailing: IconButton(
              onPressed: () {
                editThread();
              },
              icon: Icon(
                Icons.edit,
                size: 36,
                color: MyStyle().darkColor,
              )),
          leading: Icon(
            Icons.account_box_outlined,
            size: 48,
            color: MyStyle().darkColor,
          ),
          title: MyStyle().titleH2(displayName == null ? 'None' : displayName),
          subtitle: Text('Display Name User'),
        ),
      ),
    ));
  }

  Future<Null> editThread() async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: ListTile(
                leading: MyStyle().showlogo(),
                title: Text('Edit display name'),
                subtitle: Text('Please fill new display name'),
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: MyStyle().boxDecoration(),
                        width: 200,
                        child: TextFormField(
                          onChanged: (value) => displayName = value.trim(),
                          initialValue: displayName,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_box_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        )),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await Firebase.initializeApp().then((value) {
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((event) async {
                            event.updateDisplayName(displayName).then((value) {
                              findDisplayName();

                              Navigator.pop(context);
                            });
                          });
                        });
                      },
                      child: Text('OK'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
              ],
            ));
  }
}
