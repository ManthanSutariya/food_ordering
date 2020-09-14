import 'dart:convert' as JSON;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:food_ordering/screen/homescreen.dart';
import 'package:food_ordering/screen/login_with_email.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

final facebookLogin = FacebookLogin();
TextEditingController _countryCode = TextEditingController();
TextEditingController _phoneNumber = TextEditingController();
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
var currentUser;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Foodie',
          style: TextStyle(
              fontFamily: 'Lobster',
              fontWeight: FontWeight.bold,
              fontSize: size.height / 25,
              color: Colors.black87),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Icon(
            Icons.keyboard_arrow_down,
            size: size.height / 20,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Get Started',
                style: TextStyle(
                    fontFamily: 'Comfortaa', fontSize: size.height / 30),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Enter Your Phone Number And We Will Send An OTP to Continue',
                style: TextStyle(
                    fontSize: size.height / 50, color: Colors.black54),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CountryCodePicker(
                    alignLeft: true,
                    onChanged: (value) {
                      setState(() {
                        _countryCode.text = value.dialCode.toString();
                      });
                      print('Country Code : ${_countryCode.text}');
                    },
                    initialSelection: "Canada",
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: TextField(
                    controller: _phoneNumber,
                    obscureText: false,
                    autofocus: false,
                    decoration: InputDecoration(hintText: "Phone Number"),
                  ),
                ),
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: RaisedButton(
                onPressed: () {},
                color: Colors.grey,
                padding: EdgeInsets.all(size.height / 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(size.width / 30),
                  ),
                ),
                child: Text(
                  'Send OTP',
                  style: TextStyle(
                      fontSize: size.height / 45, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'OR',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            signInButton(
                icon: Icons.email,
                title: 'Continue With Email',
                color: Colors.redAccent,
                size: size,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginWithEmail()));
                }),
            signInButton(
                icon: FontAwesome.apple,
                title: 'Continue With Email',
                color: Colors.black54,
                size: size,
                function: () {}),
            Row(children: [
              Flexible(
                child: signInButton(
                    icon: FontAwesome.facebook,
                    title: 'Facebook',
                    color: Colors.blue,
                    size: size,
                    function: () async {
                      final result = await facebookLogin.logIn(['email']);

                      final token = result.accessToken;
                      final graphRespose = await http.get(
                          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
                      final profile = JSON.jsonDecode(graphRespose.body);
                      print(profile);
                    }),
              ),
              SizedBox(
                width: size.width / 50,
              ),
              Flexible(
                child: signInButton(
                    icon: FontAwesome.google,
                    title: 'Google',
                    color: Colors.redAccent,
                    size: size,
                    function: () async {
                      final user = await _googleSignIn.signIn();
                      setState(() {
                        currentUser = user;
                        print(currentUser);
                      });
                    }),
              ),
            ]),
            SizedBox(
              height: size.height / 30,
            ),
            Column(children: [
              Text(
                'By continuing, you agree to ',
                style: TextStyle(
                    fontSize: size.height / 60, color: Colors.black54),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Terms of Service',
                  style: TextStyle(
                      fontSize: size.height / 65, color: Colors.black54),
                ),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                      fontSize: size.height / 65, color: Colors.black54),
                ),
                Text(
                  'Content Policies',
                  style: TextStyle(
                      fontSize: size.height / 65, color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

signInButton(
    {IconData icon, String title, Color color, size, Function function}) {
  return ConstrainedBox(
    constraints: BoxConstraints(minWidth: double.infinity),
    child: RaisedButton.icon(
      color: Colors.white,
      elevation: 0.0,
      padding: EdgeInsets.all(size.height / 70),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.all(
          Radius.circular(size.width / 30),
        ),
      ),
      onPressed: function,
      icon: Icon(
        icon,
        color: color,
        size: 30,
      ),
      label: Text(
        title,
        style: TextStyle(fontSize: size.height / 55),
      ),
    ),
  );
}
