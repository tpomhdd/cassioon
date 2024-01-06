

import 'package:cassion23/Widgets/man_widget/mytext.dart';
import 'package:cassion23/theme/color.dart';
import 'package:cassion23/utrls/theme/theme_helper.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Widgets/drawer.dart';
class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {

    Future getdata() async{

      Uri uri =     Uri.parse("https://tpowep.com/pro/api/mes.php");
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        print(response.statusCode);
        print(json.decode(response.body));
      } else {
        print(response.statusCode);
      }


      String jsonsDataString = response.body.toString();
      var    _data = jsonDecode(jsonsDataString);
      print(_data.toString());


      return _data;

    }
    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;

    return  Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(


        drawer: drawer(),

    appBar: AppBar(
    backgroundColor: mycolor.primary,
    title: MyText(color: Colors.white, text: 'رسائل المدير', size: 15),
    ),



          body: FutureBuilder(
              future: getdata(),
              builder:(BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(

                      itemCount: snapshot.data.length,

                      itemBuilder: (context,i) {
                        return ListTile(
                          title: Container(
                            width: mdw/2,
                            height:mdh/2,
//                        color: Colors.amber,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                        color:Colors.blue,
                        boxShadow: [
                        BoxShadow(


                        )

                        ]


                        ),
                        child:Container(
                            color:mycolor.primary,
                            child: MyText(color: Colors.white, text: snapshot.data[i]['text'], size: 22)),
                          ),
                          subtitle: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(snapshot.data[i]['dete'].toString(),),
                              ),
                            ],
                          ),

                        );

                      }
                  );

                }
                else
                  return CircularProgressIndicator();
              }
          )

      ),
    );
  }
}
