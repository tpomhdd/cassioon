import 'dart:io';

import 'package:cassion23/Client/mydata.dart';
import 'package:cassion23/Screen/LoginScreen.dart';
import 'package:cassion23/Widgets/homescreen/Paths.dart';

import 'package:cassion23/Widgets/homescreen/information.dart';
import 'package:cassion23/Widgets/man_widget/mytext.dart';
import 'package:cassion23/send.dart';
import 'package:cassion23/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Widgets/drawer.dart';
FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> _messageHandler(RemoteMessage message) async {
  print('b');
}
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseMessaging.onMessageOpenedApp;


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global=MyHttpOverrides();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),

    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
@override
  void initState() {
  mydata.request();

  // TODO: implement initState
    super.initState();
  }  @override
  Widget build(BuildContext context) {
mydata.cheakpreference();
getdata();
  return  WillPopScope(
    onWillPop: () async{




   exit(0); },

    child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: drawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: MyText(color: Colors.black, text: 'الصفحة الشخصية', size: 22),

leading:               Icon(Icons.list,size: 35,),          ),
          body: ListView
            (
          children: [

            Container(
              height: MediaQuery.of(context).size.height/2,

              child:test(),

            ),

            Container(
              height: MediaQuery.of(context).size.height/2,


              child:  Paths(),

            ),


          ],
          ),
        ),
      ),
  );
  }
}





