import 'package:flutter/material.dart';
import 'package:insta_app/pages/home_page.dart';
import 'package:insta_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 251, 255, 1),
      // backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: LoginPaint(),
                child: Container(
                  margin: EdgeInsets.only(top: 120),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "InstaApp",
                      style: TextStyle(
                          fontFamily: 'Shalma',
                          // fontStyle: FontStyle.,
                          fontSize: 120,
                          // fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Color.fromRGBO(19, 73, 123, 1),
                          fontSize: 40,
                          fontWeight: FontWeight.w800),
                    ),
                    /* Text(
                      "Login for shop",
                      style: TextStyle(color: Colors.grey[400]),
                    ), */
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Email",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(19, 73, 123, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 00),
                      height: 50,
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        enableSuggestions: true,
                        keyboardType: TextInputType.emailAddress,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color.fromRGBO(70, 208, 2017, 1),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            suffixIcon:
                                Icon(Icons.email_outlined, color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(19, 73, 123, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 00),
                      height: 50,
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        obscureText: true,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        cursorColor: Color.fromRGBO(70, 208, 2017, 1),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Confirm Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(19, 73, 123, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 00),
                      height: 50,
                      padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        obscureText: true,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        cursorColor: Color.fromRGBO(70, 208, 2017, 1),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(19, 73, 123, 1),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          splashColor: Color.fromRGBO(19, 73, 123, 0.3),
                          child: Center(
                              child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "I have an account",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(19, 73, 123, 1),
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    // paint.color = Colors.blue[200];
    paint.color = Color.fromRGBO(70, 208, 2017, 1);
    paint.style = PaintingStyle.fill;

    double w = size.width;
    double h = size.height;
    Path path = new Path();
    path.moveTo(0, h * 0.5);
    path.lineTo(w * 0.03, h * 0.47);
    path.lineTo(w * 0.4, h * 0.3);
    path.quadraticBezierTo(w / 2, h / 4, w * 0.6, h * 0.3);

    path.lineTo(w * 0.97, h * 0.47);
    path.lineTo(w, h / 2);
    path.lineTo(w, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
