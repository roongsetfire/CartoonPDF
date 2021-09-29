import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roongpdf/models/cartoon_model.dart';
import 'package:roongpdf/utility/my_style.dart';
import 'package:roongpdf/widget/show_pdf_view.dart';

class ShowCartoonList extends StatefulWidget {
  @override
  _ShowCartoonListState createState() => _ShowCartoonListState();
}

class _ShowCartoonListState extends State<ShowCartoonList> {
  List<Widget> widgets = [];
  List<CartoonModel> cartoonModels = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('initialize success');
      FirebaseFirestore.instance
          .collection('cartoon')
          .orderBy('order')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');

        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          CartoonModel model = CartoonModel.fromMap(map);
          cartoonModels.add(model);
          print('name = $model');
          setState(() {
            widgets.add(createWidget(model));
          });
        }
      });
    });
  }

  Widget createWidget(CartoonModel model) => GestureDetector(
        onTap: () {
          print('Click from ${model.order}');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShowPDFView(
                        cartoonModel: model,
                      )));
        },
        child: Card(
          color: MyStyle().lightColor,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 130, child: Image.network(model.cover)),
                SizedBox(
                  height: 7,
                ),
                Text(model.name,style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.extent(
              maxCrossAxisExtent: 300,
              children: widgets,
            ),
    );
  }
}
