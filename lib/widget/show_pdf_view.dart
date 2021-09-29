import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:roongpdf/models/cartoon_model.dart';
import 'package:roongpdf/utility/my_style.dart';

class ShowPDFView extends StatefulWidget {
  final CartoonModel cartoonModel;
  ShowPDFView({Key key, this.cartoonModel}) : super(key: key);

  @override
  _ShowPDFViewState createState() => _ShowPDFViewState();
}

class _ShowPDFViewState extends State<ShowPDFView> {
  CartoonModel model;
  PDFDocument pdfDocument;
  @override
  void initState() {
    super.initState();
    model = widget.cartoonModel;
    createPDFDocument();
  }

  Future<Null> createPDFDocument() async {
    try {
      var result = await PDFDocument.fromURL(model.pdf);
      setState(() {
        pdfDocument = result;
      });
    } catch (e) {
      print('error => ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        centerTitle: true,
        title: Text(model.name == null ? 'Read Cartoon' : model.name),
      ),
      body: pdfDocument == null
          ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 30,),
              MyStyle().titleH1('Downloading...')
            ],
          ))
          : PDFViewer(document: pdfDocument),
    );
  }
}
