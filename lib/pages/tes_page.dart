import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/pages/add_page.dart';
import 'package:insta_app/pages/update_page.dart';

import 'info_page.dart';
import 'listview_page.dart';

class TesPage extends StatefulWidget {
  @override
  _TesPageState createState() => _TesPageState();
}

class _TesPageState extends State<TesPage> {
  TextEditingController recipeInputController;
  TextEditingController nameInputController;
  String id;
  final db = FirebaseFirestore.instance;
  //final _formKey = GlobalKey<FormState>();
  String name;
  String recipe;

  //create function for delete one register
  void deleteData(DocumentSnapshot doc) async {
    await db.collection('colrecipes').doc(doc.id).delete();
    setState(() => id = null);
  }

  //create tha funtion navigateToDetail
  navigateToDetail(DocumentSnapshot ds) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyUpdatePage(
                  ds: ds,
                )));
  }

  //create tha funtion navigateToDetail
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
    CommonThings.size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('View Page1'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            tooltip: 'List',
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => MyListPage());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("colrecipes").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('"Loading...');
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
                  return new Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () => navigateToDetail(doc),
                                child: new Container(
                                  child: Image.network(
                                    // '${doc.data["image"]}' + '?alt=media',
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
                                snapshot.data.docs[index]['recipe'],
                                // doc.data["recipe"],
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 12.0),
                              ),
                              onTap: () => navigateToDetail(doc),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                child: new Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () =>
                                          deleteData(doc), //funciona
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () => navigateToInfo(doc),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => MyAddPage());
          Navigator.push(context, route);
        },
      ),
    );
  }
}
