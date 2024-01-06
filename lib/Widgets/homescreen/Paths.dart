import 'package:cassion23/Widgets/man_widget/Btn.dart';
import 'package:cassion23/theme/color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cassion23/Client/mydata.dart';

import 'package:cassion23/Widgets/man_widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Client/sqllite/db.dart';

class Paths extends StatefulWidget {
  const Paths({Key? key}) : super(key: key);

  @override
  State<Paths> createState() => _PathsState();
}

class _PathsState extends State<Paths> {
  bool selected = true;
  String path = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mydata.getdatasql(),
        builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshott) {
          if (snapshott.hasData) {

            //print("x=-=" + tempDateold.toString());
            if(snapshott.data![0]['time'].toString()!="0") {
              DateTime tempDateold = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(
                  snapshott.data![0]['time'].toString());

              if (tempDateold.hour != null) {
                if (DateTime
                    .now()
                    .hour >= 6 &&
                    (
                        tempDateold.hour
                            //storage.getItem("hour")
                            < 6
                            ||
                            //storage.getItem("day")
                            tempDateold.day
                                != DateTime
                                .now()
                                .day)
                ) {
                setState(() {
                  SqlDb db = new SqlDb();


                  selected = true;
                  db.updateData(
                      "update information SET path =0");

                  db.updateData(
                      "update information SET time =0");

                });}
              }
            }
    return snapshott.data![0]['path'] == "0"
                ? Container(
                    height: 200,
                    child: FutureBuilder(
                        future: mydata.getPaths(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                for (int i = 0; i < snapshot.data.length; i++)
                                  Container(
                                    height: 100,
                                    child: MyButton(
                                      text: snapshot.data[i]['form'],

                                      mycolor:Colors.indigo,
                                      onPressed: () async {
                                        SqlDb db = new SqlDb();
                                        bool mycheak=await   mydata.getnum( snapshot.data[i]['id'].toString()
                                          ,  snapshot.data[i]['name'].toString(),

                                          snapshot.data[i]['count'].toString(),);
//                                        var name=db.readData("select name form information ");

                                        String user=await mydata.get_preferences('user');
                                        SharedPreferences preferences=await SharedPreferences.getInstance();
                                        String username=  preferences.getString('user').toString();



mycheak?
                                        setState(() {


                                          print(user.toString());
                                          print( snapshott.data![0]['name'].toString());
                                          selected = false;
                                          path = snapshot.data[i]['form'];
                                          db.updateData(
                                              "update information SET path ='${path}'");
                                          var mytimer=DateTime.now();
                                          DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(DateTime.now().toString());


                                          mydata.post(snapshot.data[i]['id'] ,snapshott.data![0]['name'].toString(),username);
                                          print("object"+tempDate.toString());

                                          db.updateData(
                                              "update information SET time ='${tempDate.toString()}'");

                                          print('object');
                                        })
                                        :Get.snackbar("لا يمكن الحجز", "الحجز ممتلئ") ;

                                      },
                                    ),
                                  )
                              ],
                            );
                          } else
                            return CircularProgressIndicator();
                        }))
                : FutureBuilder(
                    future: mydata.getdatasql(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map>> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyText(
                                  color: Colors.black,
                                  text: snapshot.data![0]['path'],
                                  size: 25),
                              MyButton(
                                text: 'اعادة تعيين',
                                mycolor:mycolor.primary3 ,
                                onPressed: () async{

                                  SharedPreferences preferences=await SharedPreferences.getInstance();
                                  String username=  preferences.getString('user').toString();





                                  setState(()  {
                                    SqlDb db = new SqlDb();
                                    mydata.delpath(username.toString());

                                    selected = true;
                                    db.updateData(
                                        "update information SET path =0");

                                    db.updateData(
                                        "update information SET time =0");
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      } else
                        return MyText(color: Colors.black87, text: 'Loading', size: 12);
                    });
          } else
            return MyText(color: Colors.black87, text: 'Loading', size: 12);
        });
  }
}
