import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:insta_app/pages/info_page.dart';
import 'package:insta_app/pages/update_page.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String id;
    final db = FirebaseFirestore.instance;

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

    void deleteData(DocumentSnapshot doc) async {
      await db.collection('caption').doc(doc.id).delete();
      setState(() => id = null);
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color.fromRGBO(70, 208, 2017, 1),
        // automaticallyImplyLeading: false,
        title: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            // padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            // height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: TextField(
              cursorColor: Colors.grey,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("photos").snapshots(),
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
                  return new Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () => navigateToInfo(doc),
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
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data.docs[index]['caption'],
                                // doc.data["recipe"],
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 10),
                              ),
                              onTap: () => navigateToInfo(doc),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
