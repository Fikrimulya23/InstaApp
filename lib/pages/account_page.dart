import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.4,
          backgroundColor: Color.fromRGBO(70, 208, 2017, 1),
          // automaticallyImplyLeading: false,
          title: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    IconButton(icon: Icon(Icons.settings), onPressed: () {}),
                  ],
                ),
                // Expanded(child: SizedBox()),
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
                    Text("fikrimulya23"),
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
        body: Center());
  }
}
