import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Center());
  }
}
