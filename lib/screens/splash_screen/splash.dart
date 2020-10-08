import 'package:flutter/material.dart';
import 'package:food_ordering/screens/sign_in/loginscreen.dart';
import 'package:splashscreen/splashscreen.dart';
import '../../main.dart';

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
