import 'dart:convert';
import 'package:cassion23/Client/sqllite/db.dart';
import 'package:cassion23/Screen/LoginScreen.dart';
import 'package:cassion23/Screen/convert.dart';
import 'package:cassion23/test.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';

import '../main.dart';
class mydata{
  static Future<String>  get_preferences(String sharedname)async  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String username=  preferences.getString(sharedname).toString();
    print(username);
 return username;
     //print(sharedPreferences.get(sharedname));

  }
static send_token(String to,String msg) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': '${to}'
  };
  var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
  request.body = json.encode({
    "to": "fFuLfzbQRBmeGY42cDByiq:APA91bH428p_gyK7sc3t5H2xjHwv2t0bkQj1OxSyWcqIR8Dhw1msFajBPdMrKY7WGWagvqd9tKuTv-RMSd2n08G7Ul58DnORLLENb73Py9CVGa8AT864H3GFDuiJv84vGYQUgmllAwGP",
    "notification": {
      "title": "Check this Mobile (title)",
      "body": "${msg}",
      "mutable_content": true,
      "sound": "Tri-tone"
    },
    "data": {
      "url": "<url of media image>",
      "dl": "<deeplink action on tap of notification>"
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
  print(response.reasonPhrase);
  }

}
static  request() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,

      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }  static Future cheakpreference() async {
    SharedPreferences sharedPreferences =
        await SharedPreferences
        .getInstance();

    var user = sharedPreferences.get("user");
    if(user==null){
      SharedPreferences preferences=await SharedPreferences.getInstance();
      preferences.remove("user");
      SqlDb sqlDb=new SqlDb();
      sqlDb.deleteData("delete from information");

    }
else
  {
    Get.to(MyHome());



  }
  }
  static Future cheakdelete() async {
    SharedPreferences sharedPreferences =
    await SharedPreferences
        .getInstance();

    var user = sharedPreferences.get("user");

    SharedPreferences preferences=await SharedPreferences.getInstance();
      preferences.remove("user");
      SqlDb sqlDb=new SqlDb();
      sqlDb.deleteData("delete from information");


      Get.to(LoginScreen());




  }
  static Future logout()async  {

    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove("user");
    SqlDb sqlDb=new SqlDb();
    sqlDb.deleteData("delete from information");
    //print(sharedPreferences.get(sharedname));

  }


static  Future<bool> getnum(
      String number,
      String user,
    String cont,

      )
  async {
    bool cheak=false;
    Uri uri = Uri.parse(
        "https://tpowep.com/pro/api/countpath.php?id=$number");
    int gool=int.parse(cont);
    http.Response response = await http.get(uri);

    print(response.body);
    var jsonsDataString = response.body;
    var _data = json.decode(jsonsDataString);
    int coun = int.parse(_data);
    var username=await get_preferences("user");

    if (coun >=gool) {
      cheak=false;
    }
    else {
cheak=true;
  //    post( number, user,number);

    }

return cheak;
  }
 static delpath(String ser) async {
    var data = {
      "txt":ser,
    };
    Uri url = Uri.parse(
        "https://tpowep.com/pro/api/delpath.php");


    var reesponse = await http.post(url,body: data);
    var responsebody = jsonDecode(reesponse.body);
    print(responsebody);





  }




  static  Future getPaths() async{


    Uri uri = Uri.parse("https://tpowep.com/pro/api/api.php");
    http.Response response = await http.get(uri);
    String jsonsDataString = response.body.toString();
    var    _data = jsonDecode(jsonsDataString);

    return _data;

  }

  static  saveperf(String username,String sharedname)async  {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString(sharedname, username);
    print("user======="+sharedPreferences.get(sharedname).toString());


  }
  FirebaseMessaging messaging = FirebaseMessaging.instance;



    static Login(String username, String password) async {

        var result;

        Uri uri =     Uri.parse("https://tpowep.com/pro/api/loginmhd.php");
        var data = {"username": username, "password": password};
        var reesponse = await http.post(uri, body: data);

        //ed=responsebody;
        result = jsonDecode(reesponse.body);
        print(result);

        if (result == "Login") {
 saveperf(username, 'user');
 loginok(username);
  getdata();
 gettoken(username);
  getdatasql();
           Get.to(welcome_screen());

        }
        else
        if (result == "No Login"){

          Get.defaultDialog(title: 'التسجيل خاطئ',middleText: 'لا يمكن تسججيل الدخول');
        }

    }



static Future   post(String number,String ser,String name) async {
    var data = {
      "txt": number,
      "ser":ser,
      "name":name
    };
    Uri url = Uri.parse(
        "https://tpowep.com/pro/api/code.php");

    var reesponse = await http.post(url, body: data);
    var responsebody = jsonDecode(reesponse.body);






  }


  static Future<List<Map>> getdatasql () async{

        SqlDb sqlDb=new SqlDb();
        List<Map> result= await sqlDb.readData("SELECT *FROM information");
        print("$result");
        return result;
    }
static  Future  loginchek(String username, String password)  async {
      var response;
      SharedPreferences sharedPreferences =
      await SharedPreferences
          .getInstance();

      String user = sharedPreferences.get("user").toString();


      var result;
      bool cheak=false;



      Uri uri =     Uri.parse("https://tpowep.com/pro/api/logincheak.php?ser="+username+"");

print(uri.toString());
      var reesponse = await http.get(uri);
      result = jsonDecode(reesponse.body.toString());
      List map=result as List;
      print(result.toString());
      if(result=="[]"){

        Get.defaultDialog(title: 'التسجيل خاطئ',middleText: 'لا يمكن تسججيل الدخول');

      }
      else {
        print(result[0]['logined'].toString());
        String ok= result[0]['logined'].toString();
        print(ok);

        if (ok == "false" ) {
          Login(username, password);
        }
        else {
          Get.defaultDialog(title: 'التسجيل خاطئ',middleText: 'لا يمكن تسججيل الدخول');
        }

      }

    }

}
//https://tpowep.com/pro/api/apiallstudent.php
 Future apiallstudent(String msg) async {
   SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

   String user = sharedPreferences.get("user").toString();

   Uri uri = Uri.parse(

       "https://tpowep.com/pro/api/apiallstudent.php");
   http.Response response = await http.get(uri);
   print("result====="+response.body.toString());


     var jsonsDataString = response.body;
     var _data = json.decode(jsonsDataString);
     for(int x=0;x<_data.length;x++){
       print(_data[x]['token'].toString());
       mydata.send_token(_data[x]['token'].toString(), msg);

     }




}
Future getdata() async {
  SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

  String user = sharedPreferences.get("user").toString();

  Uri uri = Uri.parse(

      "https://casioon.tpowep.com/json" + user + "");
  http.Response response = await http.get(uri);
  print("result====="+response.body.toString());
  if (response.body.toString()== " []") {
//      Get.to(LoginScreen());
    mydata.cheakdelete();

    print("nullok");
    //  print(json.decode(response.body));
  } else {

    SqlDb sqlDb=new SqlDb();

    var jsonsDataString = response.body;
    var _data = json.decode(jsonsDataString);
    String name=_data[0]['name'].toString();
    String address=_data[0]['address'].toString();
    String Specialization=_data[0]['Specialization'].toString();


    sqlDb.insertData(
        "INSERT INTO `information` "
            "('name' , 'address','image' , 'path'  ,'time' , 'Specialization') VALUES"
            "('${name}','${address}','0','0','0','${Specialization}')");
    print(response.statusCode);
  }



}



loginok(String username) async {

    Uri uri = Uri.parse(
        "https://tpowep.com/pro/api/logined.php?name="+username+"");
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
        print(response.statusCode);
        print(json.decode(response.body));
    } else {
        print(response.statusCode);
    }

}

 Future<String> selectpath() async {
   SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

   String user = sharedPreferences.get("user").toString();
   Uri uri = Uri.parse("https://tpowep.com/pro/api/selectpath.php?user=${user}");
  http.Response response = await http.get(uri);
   var jsonsDataString = response.body;
   var _data = json.decode(jsonsDataString);

  if (response.statusCode == 200) {
    print(response.statusCode);
    print(_data[0]['id'].toString());
//    print(json.decode(response.body.toString()));
  } else {
    print(response.statusCode);
  }
  return _data[0]['id'].toString();

}
 Future<void> gettoken(String username) async {
  var response;
  var result;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.getToken().then((String? token) async {
    assert(token != null);

    response =  token.toString();

       print(response);
    Uri uri =Uri.parse("https://tpowep.com/pro/api/token.php");
    var data = {"name": username, "token": response.toString()};
    var reesponse = await http.post(uri, body: data);
    result = jsonDecode(reesponse.body);

    //ed=responsebody;
    print("x----------------------------------------"+result);
  });

}