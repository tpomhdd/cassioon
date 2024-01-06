import 'package:cassion23/Client/mydata.dart';
import 'package:cassion23/Widgets/man_widget/mytext.dart';
import 'package:flutter/material.dart';

import 'Widgets/homescreen/imgupload.dart';
import 'Widgets/homescreen/information_txt.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mydata.getdatasql(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
          if (snapshot.hasData) {
            return ListView(

              children: [
                upuimg(),

                information_txt(txt: snapshot.data![0]['name'].toString()+''),

                information_txt(txt: '${snapshot.data![0]['address']} '),

                information_txt(txt: '${snapshot.data![0]['Specialization']} '),


              ],
            );

          } else
            return CircularProgressIndicator();
        });
  }
}
