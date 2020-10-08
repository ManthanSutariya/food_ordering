import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/main.dart';
import 'package:food_ordering/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firebaseAuth = FirebaseAuth.instance;
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class LoginWithEmail extends StatefulWidget {
  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  showSnackBar({e}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(e.message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.amber,
              child: Image(
                image: AssetImage('assets/back3.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: size.height / 26,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height / 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: size.height / 5,
                ),
                Padding(
                  padding: EdgeInsets.all(size.height / 30),
                  child: Container(
                    padding: EdgeInsets.all(size.height / 30),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.all(
                        Radius.circular(size.height / 40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign up to continue',
                          style: TextStyle(fontSize: size.height / 38),
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        Consumer<CurrentUser>(
                          builder: (context, currentUser, child) {
                            return ConstrainedBox(
                              constraints:
                                  BoxConstraints(minWidth: double.infinity),
                              child: RaisedButton(
                                onPressed: () async {
                                  print(_emailController.text);
                                  print(_passwordController.text);
                                  try {
                                    UserCredential user = await _firebaseAuth
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text);

                                    currentUser.getUser(user: user.user);
                                    if (currentUser.currentUser != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyApp()));
                                    }
                                  } catch (e) {
                                    print(e.message);
                                    if (e.message ==
                                        'The email address is already in use by another account.') {
                                      final user = await _firebaseAuth
                                          .signInWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text);
                                      currentUser.getUser(user: user.user);
                                      if (currentUser.currentUser != null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyApp()));
                                      }
                                    }
                                    showSnackBar(e: e);
                                  }
                                },
                                color: Colors.pink,
                                padding: EdgeInsets.all(size.height / 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(size.width / 30),
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: size.height / 45,
                                      color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text('Or'),
                ),
                Center(
                  child: Text('Forgot Password'),
                ),
                Column(children: [
                  SizedBox(
                    height: size.height / 7,
                  ),
                  Text(
                    'By continuing, you agree to ',
                    style: TextStyle(
                        fontSize: size.height / 55,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Terms of Service',
                      style: TextStyle(
                          fontSize: size.height / 60, color: Colors.black54),
                    ),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                          fontSize: size.height / 60, color: Colors.black54),
                    ),
                    Text(
                      'Content Policies',
                      style: TextStyle(
                          fontSize: size.height / 60, color: Colors.black54),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
