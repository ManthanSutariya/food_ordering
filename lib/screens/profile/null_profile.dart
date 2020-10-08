import 'package:flutter/material.dart';
import 'package:food_ordering/screens/sign_in/loginscreen.dart';

class ProfileNull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.6,
              child: Container(
                color: Colors.black12,
                child: Padding(
                  padding: EdgeInsets.all(size.height / 40),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            Text(
                              'Live \n\bFor',
                              style: TextStyle(
                                  fontSize: size.height / 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black54),
                            ),
                            Text(
                              'Food',
                              style: TextStyle(
                                  fontSize: size.height / 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: size.height*0.04,
                        top:  size.height*0.01,
                        child: Container(
                          width: size.width / 1.9,
                          height: size.height / 3.5,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: size.height / 48, color: Colors.white),
                              color: Colors.white70,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.height / 6))),
                          child: Center(
                            child: Image(
                              image: AssetImage('assets/food1.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: size.height / 30,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Text('Login/Create Account to quickly manage order'),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, minHeight: size.height / 16),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      color: Colors.pinkAccent,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Divider(
                    thickness: size.width / 160,
                    color: Colors.black26,
                    indent: size.width / 5,
                    endIndent: size.width / 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
