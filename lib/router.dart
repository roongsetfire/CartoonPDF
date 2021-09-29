import 'package:flutter/material.dart';
import 'package:roongpdf/widget/authen.dart';
import 'package:roongpdf/widget/my_service.dart';
import 'package:roongpdf/widget/register.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
};
