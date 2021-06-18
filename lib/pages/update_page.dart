import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; //formateo hora

File image;
String filename;

class MyUpdatePage extends StatefulWidget {
  final DocumentSnapshot ds;
  MyUpdatePage({this.ds});
  @override
  _MyUpdatePageState createState() => _MyUpdatePageState();
}

class _MyUpdatePageState extends State<MyUpdatePage> {
  String productImage;
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

  @override
  void initState() {
    super.initState();
    captionInputController =
        new TextEditingController(text: widget.ds.get('caption'));
    nameInputController =
        new TextEditingController(text: widget.ds.get('name'));

    productImage = widget.ds.get('image');
    print(productImage);
  }

  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection("photos").get();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    getPosts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Page'),
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
                        (image == null)
                            ? new Container(
                                margin: EdgeInsets.only(top: 20),
                                height: MediaQuery.of(context).size.width - 50,
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: new BoxDecoration(
                                    border: new Border.all(
                                        width: 3,
                                        color: Colors.black.withOpacity(0.3))),
                                padding: new EdgeInsets.all(5.0),
                                child: productImage == ''
                                    ? Text('Edit')
                                    : Image.network(
                                        productImage + '?alt=media'),
                              )
                            : new Container(
                                margin: EdgeInsets.only(top: 20),
                                height: MediaQuery.of(context).size.width - 50,
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: new BoxDecoration(
                                  border: new Border.all(
                                      width: 3,
                                      color: Colors.black.withOpacity(0.3)),
                                ),
                                padding: new EdgeInsets.all(5.0),
                                child: image == null
                                    ? Center(
                                        child: Text(
                                        'new image',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.3)),
                                      ))
                                    : Image.file(image),
                              ),
                        //
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
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        controller: captionInputController,
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
                    )
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  Container(
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
                      child: Center(
                        child: Text(
                          "Upload",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                      onTap: () {
                        DateTime now = DateTime.now();
                        String nuevoformato =
                            DateFormat('kk:mm:ss:MMMMd').format(now);
                        var fullImageName = 'nomfoto-$nuevoformato' + '.jpg';
                        var fullImageName2 = 'nomfoto-$nuevoformato' + '.jpg';

                        final Reference ref =
                            FirebaseStorage.instance.ref().child(fullImageName);
                        // ignore: unused_local_variable
                        final UploadTask task = ref.putFile(image);

                        var part1 =
                            'https://firebasestorage.googleapis.com/v0/b/insta-app-8bc64.appspot.com/o/'; //esto cambia segun su firestore

                        var fullPathImage = part1 + fullImageName2;
                        print(fullPathImage);
                        FirebaseFirestore.instance
                            .collection('photos')
                            .doc(widget.ds.id)
                            .update({
                          'name': nameInputController.text,
                          'caption': captionInputController.text,
                          'image': '$fullPathImage'
                        });
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context)
                              .pop(); //regrese a la pantalla anterior
                        });
                        // Navigator.of(context).pop(); //regrese a la pantalla anterior
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
