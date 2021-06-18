import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyInfoPage extends StatefulWidget {
  final DocumentSnapshot ds;
  MyInfoPage({this.ds});
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  String productImage;
  String id;
  String name;
  String caption;

  // TextEditingController nameInputController;
  // TextEditingController captionInputController;

  Future getPost() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("photos").get();
    return qn.docs;
  }

  Future getComment() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("comment").get();
    return qn.docs;
  }

  @override
  void initState() {
    super.initState();

    productImage = widget.ds.get('image');
    print(productImage);
  }

  @override
  Widget build(BuildContext context) {
    getPost();
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
        backgroundColor: Color.fromRGBO(70, 208, 2017, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.883,
          // padding: EdgeInsets.all(8),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              new Container(
                // margin: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                    border: new Border.all(
                        width: 2, color: Colors.black.withOpacity(0.3))),
                padding: new EdgeInsets.all(5.0),
                child: productImage == ''
                    ? Text('Edit')
                    : Image.network(productImage + '?alt=media'),
              ),
              // new IniciarIcon(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.ds.get('name'),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.ds.get('caption'),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.4), fontSize: 12),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Comment:'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: Icon(Icons.send,
                            color: Color.fromRGBO(70, 208, 2017, 1))),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
