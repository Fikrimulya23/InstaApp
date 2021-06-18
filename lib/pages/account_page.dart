import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/pages/info_page.dart';
import 'package:insta_app/pages/update_page.dart';
import 'package:insta_app/services/auth_service.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String id;
  final db = FirebaseFirestore.instance;

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('photos').doc(doc.id).delete();
    setState(() => id = null);
  }

  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyUpdatePage(
                  ds: ds,
                )));
  }

  navigateToInfo(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyInfoPage(
                  ds: ds,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.4,
        backgroundColor: Color.fromRGBO(70, 208, 2017, 1),
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        print(_auth.currentUser.email);
                        // AuthServices().signOut();
                      }),
                ],
              ),

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(150)),
                    child: Icon(Icons.photo),
                  ),
                  Text(_auth.currentUser.email),
                ],
              ),
              // Text("Fikri Mulya"),

              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Text(
                      "~good night",
                      style: TextStyle(fontSize: 13),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {},
                          child: Icon(
                            Icons.edit,
                            size: 15,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("photos")
              .where('name', isEqualTo: _auth.currentUser.email)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            int length = snapshot.data.docs.length;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //two columns
                  mainAxisSpacing: 0.1, //space the card
                  childAspectRatio: 0.800, //space largo de cada card
                ),
                itemCount: length,
                padding: EdgeInsets.all(2.0),
                itemBuilder: (_, int index) {
                  final DocumentSnapshot doc = snapshot.data.docs[index];

                  return Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () => navigateToInfo(doc),
                                child: new Container(
                                  child: Image.network(
                                    '${snapshot.data.docs[index]["image"]}' +
                                        '?alt=media',
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace stackTrace) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  ),
                                  width: 170,
                                  height: 120,
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                snapshot.data.docs[index]['name'],
                                // doc.data["name"],
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 19.0,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data.docs[index]['caption'],
                                // doc.data["recipe"],
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 12.0),
                              ),
                              onTap: () => navigateToInfo(doc),
                            ),
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 170,
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () =>
                                          deleteData(doc), //funciona
                                    ),
                                    // Expanded(child: SizedBox()),
                                    // SizedBox(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () => navigateToDetail(doc),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
