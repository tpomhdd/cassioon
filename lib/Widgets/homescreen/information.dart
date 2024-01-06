import 'package:cassion23/Widgets/homescreen/imgupload.dart';
import 'package:cassion23/Widgets/homescreen/information_txt.dart';
import 'package:cassion23/Widgets/man_widget/mytext.dart';
import 'package:cassion23/utrls/theme/theme_helper.dart';
import 'package:flutter/material.dart';
class information_widget extends StatefulWidget {
  const information_widget({Key? key}) : super(key: key);

  @override
  State<information_widget> createState() => _information_widgetState();
}

class _information_widgetState extends State<information_widget> {
  @override
  Widget build(BuildContext context) {
    return ListView(

      children: [
upuimg(),

information_txt(txt: 'الاسم : محمد المصري'),

        information_txt(txt: 'الكلية الهندسة'),

        information_txt(txt: 'السنة الرابعة'),


      ],
    );
  }
}
