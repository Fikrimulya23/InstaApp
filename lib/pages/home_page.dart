import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/pages/info_page.dart';
import 'package:insta_app/pages/update_page.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id;
  final db = FirebaseFirestore.instance;

  //create function for delete one register
  void deleteData(DocumentSnapshot doc) async {
    await db.collection('photos').doc(doc.id).delete();
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromRGBO(70, 208, 2017, 1),
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  // alignment: Alignment.centerLeft,
                  child: Text(
                    "InstaApp",
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'Shalma',
                        color: Colors.white),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.chat_bubble_outline),
                    onPressed: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TesPage(),
                          )); */
                    }),
              ],
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("photos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          int length = snapshot.data.docs.length;

          return ListView.builder(
            itemCount: length,
            itemBuilder: (_, int index) {
              final DocumentSnapshot doc = snapshot.data.docs[index];
              return new Container(
                padding: new EdgeInsets.all(3.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => navigateToInfo(doc),
                        child: new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: Image.network(
                            '${snapshot.data.docs[index]["image"]}' +
                                '?alt=media',
                          ),
                          width: MediaQuery.of(context).size.width - 50,
                          height: MediaQuery.of(context).size.width - 50,
                        ),
                      ),
                      Container(
                        height: 3,
                        color: Colors.grey[100],
                      ),
                      Container(
                        child: ListTile(
                          title: Text(
                            snapshot.data.docs[index]['name'],
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data.docs[index]['caption'],
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 12),
                          ),
                          onTap: () => navigateToInfo(doc),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(70, 208, 2017, 1),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => MyAddPage());
          Navigator.push(context, route);
        },
      ),
    );
  }
}
