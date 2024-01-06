import 'package:cassion23/theme/color.dart';
import 'package:flutter/material.dart';

import '../../utrls/theme/theme_helper.dart';
import '../man_widget/mytext.dart';
class information_txt extends StatefulWidget {
  final String txt;
  const information_txt({Key? key, required this.txt}) : super(key: key);

  @override
  State<information_txt> createState() => _information_txtState();
}

class _information_txtState extends State<information_txt> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        decoration: ThemeHelper().myBoxDecoration(context,mycolor.primary3,mycolor.primary),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle,size: 30,color: Colors.white,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyText(color: Colors.white, text: widget.txt, size: 20,fontWeight: FontWeight.w500,),
            )

          ],
        ),


      ),
    );
  }
}
