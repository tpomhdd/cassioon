import 'package:cassion23/Client/mydata.dart';
import 'package:cassion23/Client/sqllite/db.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class upuimg extends StatefulWidget {
  const upuimg({Key? key}) : super(key: key);

  @override
  State<upuimg> createState() => _upuimgState();
}

class _upuimgState extends State<upuimg> {
  @override

  XFile? image;
  SqlDb db=new SqlDb();
  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      db.updateData("update information SET image ='${img!.path.toString()}'");


      print(img!.path.toString());
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: mydata.getdatasql(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                //if image not null show the image
                //if image null show text
                snapshot.data![0]['image'] != '0'
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      //to show image, you type like this.
                      File(snapshot.data![0]['image']),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
                )
                    :
                ElevatedButton(
                  onPressed: () {
                    myAlert();
                  },
                  child: Text('Upload Photo'),
                ),],
            );

          } else
            return CircularProgressIndicator();
        });
  }
}



