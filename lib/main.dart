import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:food_ordering/screens/cart_screen/cart.dart';
import 'package:food_ordering/screens/profile/null_profile.dart';
import 'package:food_ordering/screens/profile/profile.dart';
import 'package:food_ordering/screens/provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'file:///C:/AndroidStudioProject/food_ordering/lib/screens/home_screen/homescreen.dart';
import 'screens/search_screen/search_screen.dart';

void main() async {
  GetIt.I.registerLazySingleton<Cart>(() => Cart());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'Comfortaa'),
          debugShowCheckedModeBanner: false,
          home: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeScreen(),
      SreachScreen(),
      CartScreen(),
      Provider.of<CurrentUser>(context).currentUser == null
          ? ProfileNull()
          : Profile()
    ];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: size.height / 11,
        color: Colors.redAccent,
        items: <Widget>[
          Icon(
            Icons.home,
            size: size.height / 30,
            color: Colors.white,
          ),
          Icon(
            FontAwesome.search,
            size: size.height / 35,
            color: Colors.white,
          ),
          Icon(
            FontAwesome.opencart,
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
