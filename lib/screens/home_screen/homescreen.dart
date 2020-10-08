import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///C:/AndroidStudioProject/food_ordering/lib/screens/home_screen/crawings_screen.dart';
import 'package:food_ordering/screens/storescreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int selectedIndex = 0;
String random = Random().nextInt(5).ceilToDouble().toString();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width / 50, vertical: size.height / 100),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(FontAwesome.location),
                    Text(
                      'Katargam',
                      style: TextStyle(fontSize: size.height / 47),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 60,
                ),
                SizedBox(
                  height: size.height / 20,
                  child: Row(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          itemCount: 2,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => categoryButton(
                            size: size,
                            currentIndex: index,
                            selectedIndex: selectedIndex,
                            tap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Top Brands in spotlight',
                  style: TextStyle(
                      fontSize: size.height / 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                SizedBox(
                  height: size.height / 6,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Restaurant')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                final storeName =
                                    snapshot.data.docs[index].data()['name'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoreScreen(
                                              storeName: storeName,
                                            )));
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.width / 25),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.width / 20)),
                                      child: Image.network(
                                        '${snapshot.data.docs[index].data()['logoUrl']}',
                                        fit: BoxFit.cover,
                                        height: size.height * 0.14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                      snapshot.data.docs[index].data()['name']),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Text(
                  'LockDown Crawings',
                  style: TextStyle(fontSize: size.height / 40),
                ),
                AspectRatio(
                  aspectRatio: 1.5,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('LockDown Crawings')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return GridView.builder(
                          itemCount: 6,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: size.width / 3,
                                  mainAxisSpacing: 0),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                final crawingsName = await snapshot.data.docs[0]
                                    .data()['crawings'][index]['name'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CrawingsScreen(
                                      searchQuery: crawingsName,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(size.width / 40),
                                      height: size.height / 9,
                                      width: size.width / 3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(size.height / 60),
                                        ),
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            snapshot.data.docs[0]
                                                    .data()['crawings'][index]
                                                ['crawingsLogo'],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(snapshot.data.docs[0]
                                        .data()['crawings'][index]['name']),
                                  ]),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                Text(
                  'Latest Offer',
                  style: TextStyle(fontSize: size.height / 40),
                ),
                getOffers(size: size),
                SizedBox(
                  height: size.height / 30,
                ),
                Text(
                  'SpotLight Products',
                  style: TextStyle(fontSize: size.height / 40),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                getSpotLightProduct(size: size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

categoryButton(
    {size, int selectedIndex, int currentIndex, Function tap, String title}) {
  return GestureDetector(
    onTap: tap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width / 50),
      child: Text(
        currentIndex == 0 ? 'Food' : 'Dishes',
        style: TextStyle(
          fontSize: size.height / 40,
          fontWeight: selectedIndex == currentIndex
              ? FontWeight.bold
              : FontWeight.normal,
          color: selectedIndex == currentIndex
              ? Color.fromRGBO(142, 22, 0, 1)
              : Colors.black54,
        ),
      ),
    ),
  );
}

getOffers({size}) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('Offers').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return AspectRatio(
          aspectRatio: 3,
          child: ListView.builder(
              itemCount: snapshot.data.docs[0].data()['off'].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  height: size.height / 10,
                  width: size.width / 1.3,
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(size.height / 40),
                    ),
                  ),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        snapshot.data.docs[0].data()['off'][index]['imageUrl']),
                  ),
                );
              }),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

getSpotLightProduct({size}) {
  return StreamBuilder(
    stream:
        FirebaseFirestore.instance.collection('SpotLight Products').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          primary: false,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              height: size.height / 2.5,
              child: GestureDetector(
                onTap: () {
                  print('Product');
                },
                child: Card(
                  shape: OutlineInputBorder(),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(size.height / 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          snapshot.data.docs[0]
                                                  .data()['products'][index]
                                              ['product_name'],
                                          style: TextStyle(
                                              fontSize: size.height / 37,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        'from ${snapshot.data.docs[0].data()['products'][index]['store_name']}',
                                        style: TextStyle(
                                            fontSize: size.height / 60),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '\$ ${snapshot.data.docs[0].data()['products'][index]['price']}',
                                    style: TextStyle(
                                        fontSize: size.height / 37,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: size.height / 3.5,
                              width: double.infinity,
                              child: ClipRRect(
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      snapshot.data.docs[0].data()['products']
                                          [index]['product_image_url']),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
