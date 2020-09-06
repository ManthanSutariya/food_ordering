import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

TextEditingController _countryCode = TextEditingController();
TextEditingController _phoneNumber = TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
            print('close');
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
                style: TextStyle(fontFamily: 'Comfortaa', fontSize: size.height / 30),
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
                size: size),
            signInButton(
                icon: FontAwesome.apple,
                title: 'Continue With Email',
                color: Colors.black54,
                size: size),
            Row(children: [
              Flexible(
                child: signInButton(
                    icon: FontAwesome.facebook,
                    title: 'Facebook',
                    color: Colors.blue,
                    size: size),
              ),
              SizedBox(
                width: size.width / 50,
              ),
              Flexible(
                child: signInButton(
                    icon: FontAwesome.google,
                    title: 'Google',
                    color: Colors.redAccent,
                    size: size),
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

signInButton({IconData icon, String title, Color color, size}) {
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
      onPressed: () {},
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
