import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:food_ordering/screen/loginscreen.dart';
import 'package:food_ordering/screen/profile.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/screen/homescreen.dart';
import 'screen/search_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
        theme: ThemeData(fontFamily: 'Comfortaa'),
        debugShowCheckedModeBanner: false,
        home: Splash()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;

  List<Widget> pages = [HomeScreen(), SreachScreen(), Profile()];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: size.height / 11,
        color: Colors.redAccent,
        items: <Widget>[
          Icon(
            Icons.add,
            size: size.height / 30,
            color: Colors.white,
          ),
          Icon(
            FontAwesome.search,
            size: size.height / 35,
            color: Colors.white,
          ),
          Icon(
            Icons.account_circle,
            size: size.height / 25,
            color: Colors.white,
          ),
        ],
        index: 0,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
      resizeToAvoidBottomPadding: false,
      body: pages[pageIndex],
    );
  }
}

var user;

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SplashScreen(
      seconds: 5,
      image: Image(
        image: NetworkImage(
            'https://cdn6.f-cdn.com/contestentries/1015573/24019110/590aa4718b9de_thumb900.jpg'),
      ),
      photoSize: size.height / 4,
      loaderColor: Colors.white,
      navigateAfterSeconds: user==null? LoginScreen() : MyApp(),
    );
  }
}
