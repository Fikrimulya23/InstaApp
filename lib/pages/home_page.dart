import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
        body: Center());
  }
}
