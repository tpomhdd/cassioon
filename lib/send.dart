import 'package:cassion23/Client/mydata.dart';
import 'package:cassion23/Widgets/man_widget/Btn.dart';
import 'package:cassion23/Widgets/man_widget/textfiled.dart';
import 'package:flutter/material.dart';
class Send_Masseges extends StatefulWidget {
  const Send_Masseges({Key? key}) : super(key: key);

  @override
  State<Send_Masseges> createState() => _Send_MassegesState();
}

class _Send_MassegesState extends State<Send_Masseges> {
  TextEditingController txt=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyTextField(text: 'text', mycolor: Colors.white,controller: txt,),
          MyButton(text: 'Send', mycolor: Colors.black,onPressed: (){
            apiallstudent(txt.text);
          },)
        ],
      ),
    );
  }
}
