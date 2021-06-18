import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; //formateo hora

File image;
String filename;

class CommonThings {
  static Size size;
}

class MyAddPage extends StatefulWidget {
  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  TextEditingController captionInputController;
  TextEditingController nameInputController;
  TextEditingController imageInputController;

  String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  String caption;

  pickerCam() async {
    PickedFile img = await ImagePicker().getImage(source: ImageSource.camera);
    if (img != null) {
      image = File(img.path);
      setState(() {});
    }
  }

  pickerGallery() async {
    PickedFile img = await ImagePicker().getImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      setState(() {});
    }
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  void createData() async {
    DateTime now = DateTime.now();
    String nuevoformato = DateFormat('kk:mm:ss:MMMMd').format(now);
    var fullImageName = 'nomfoto-$nuevoformato' + '.jpg';
    var fullImageName2 = 'nomfoto-$nuevoformato' + '.jpg';

    FirebaseAuth _auth = FirebaseAuth.instance;

    final Reference ref = FirebaseStorage.instance.ref().child(fullImageName);
    // ignore: unused_local_variable
    final UploadTask task = ref.putFile(image);

    var part1 =
        'https://firebasestorage.googleapis.com/v0/b/insta-app-8bc64.appspot.com/o/';

    var fullPathImage = part1 + fullImageName2;
    print(fullPathImage);

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db.collection('photos').add({
        'name': _auth.currentUser.email,
        'caption': '$caption',
        'image': '$fullPathImage'
      });
      setState(() => id = ref.id);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(); //regrese a la pantalla anterior
        image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
        backgroundColor: Color.fromRGBO(70, 208, 2017, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 100,
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(top: 20),
                          height: MediaQuery.of(context).size.width - 50,
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: new BoxDecoration(
                            border: new Border.all(
                                width: 3, color: Colors.black.withOpacity(0.3)),
                          ),
                          padding: new EdgeInsets.all(5.0),
                          child: image == null
                              ? Center(
                                  child: Text(
                                  'new image',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.3)),
                                ))
                              : Image.file(image),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(40)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: pickerCam,
                                child: Center(
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(40)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(40),
                                onTap: pickerGallery,
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'caption',
                          fillColor: Colors.black.withOpacity(0.1),
                          filled: true,
                        ),
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some caption';
                          }
                        },
                        onSaved: (value) => caption = value,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Container(
                // alignment: Alignment.bottomCenter,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(70, 208, 2017, 1),
                ),
                child: InkWell(
                  onTap: createData,
                  child: Center(
                    child: Text(
                      "Upload",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
