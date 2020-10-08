import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:food_ordering/screens/more_info_screen.dart';
import 'package:food_ordering/widgets/addBotton.dart';
import 'package:food_ordering/widgets/rating.dart';

class StoreScreen extends StatefulWidget {
  final String storeName;

  StoreScreen({this.storeName});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int productsLength;

  getlength() async {
    await FirebaseFirestore.instance
        .collection('Restaurant')
        .where('name', isEqualTo: widget.storeName.toString())
        .get()
        .then((value) {
      setState(() {
        productsLength = value.docs[0].data()['products'].length;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlength();
  }

  double currentRating;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 46),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreInfoScreen(
                          storeName: widget.storeName,
                        ),
                      ),
                    ),
                    child: Text(
                      'more info',
                      style: TextStyle(
                          color: Colors.red, fontSize: size.height / 40),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 46),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.storeName,
                  style: TextStyle(
                      fontSize: size.height / 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height / 120,
                ),
                Row(
                  children: [
                    CustomWidgets.rating(
                        size: size,
                        updateRating: (value) {
                          setState(() {
                            currentRating = value;
                          });
                        }),
                    Text(
                      currentRating != null ? currentRating.toString() : '0.0',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 80,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesome5.arrow_alt_circle_down,
                            color: Colors.red,
                            size: size.height / 40,
                          ),
                          SizedBox(
                            width: size.width / 70,
                          ),
                          Text(
                            'Recommended',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height / 40),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width / 40,
                      ),
                      AspectRatio(
                        aspectRatio: 1.2,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Restaurant')
                              .where('name', isEqualTo: widget.storeName)
                              .get()
                              .then((value) => value)
                              .asStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productsLength,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: size.height / 4,
                                            width: size.height / 3,
                                            color: Colors.white,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    size.height / 50),
                                              ),
                                              child: Image(
                                                image: NetworkImage(
                                                  snapshot.data.docs[0]
                                                          .data()['products']
                                                      [index]['imageUrl'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width / 30,
                                                vertical: size.height / 40),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: size.height / 10,
                                                  width: size.width / 2.5,
                                                  child: Text(
                                                    snapshot.data.docs[0]
                                                            .data()['products']
                                                        [index]['name'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                getAddToCartBotton(
                                                    size: size,
                                                    context: context),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                      Text(
                        'Happy Meals',
                        style: TextStyle(
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Restaurant')
                            .where('name', isEqualTo: widget.storeName)
                            .get()
                            .then((value) => value)
                            .asStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: productsLength,
                              primary: false,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height / 80),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _buttomSheet(
                                              context: context,
                                              size: size,
                                              snapshot: snapshot,
                                              index: index);
                                        },
                                        child: Container(
                                          height: size.height / 8,
                                          width: size.width / 4,
                                          margin: EdgeInsets.only(
                                              bottom: size.height / 70,
                                              right: size.width / 40),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(size.height / 40),
                                            ),
                                            child: Image(
                                              image: NetworkImage(
                                                snapshot.data.docs[0]
                                                        .data()['products']
                                                    [index]['imageUrl'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: size.height / 40,
                                            width: size.width / 2,
                                            child: Text(
                                              snapshot.data.docs[0]
                                                      .data()['products'][index]
                                                  ['name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.height / 48),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height / 79,
                                          ),
                                          Text(
                                            '\$ ${snapshot.data.docs[0].data()['products'][index]['price']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.height / 50),
                                          ),
                                          SizedBox(
                                            height: size.height / 79,
                                          ),
                                          Container(
                                            width: size.width / 2,
                                            height: size.height / 16,
                                            child: Text(
                                              snapshot.data.docs[0]
                                                      .data()['products'][index]
                                                  ['description'],
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                      getAddToCartBotton(
                                          name: snapshot.data.docs[0].data()['products']
                                              [index]['name'],
                                          price: snapshot.data.docs[0]
                                                  .data()['products'][index]
                                              ['price'],
                                          descripion: snapshot.data.docs[0]
                                                  .data()['products'][index]
                                              ['price'],
                                          imageUrl: snapshot.data.docs[0]
                                                  .data()['products'][index]
                                              ['imageUrl'],
                                          storeName: widget.storeName,
                                          address: snapshot.data.docs[0]
                                              .data()['address'],
                                          size: size,
                                          context: context),
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
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

_buttomSheet({context, size, AsyncSnapshot snapshot, index}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
          padding: EdgeInsets.all(size.height / 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height / 3,
                width: size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(size.height / 40),
                  ),
                  child: Image(
                    image: NetworkImage(
                      snapshot.data.docs[0].data()['products'][index]
                          ['imageUrl'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height / 20,
                        width: size.width / 1.5,
                        child: Text(
                          snapshot.data.docs[0].data()['products'][index]
                              ['name'],
                          style: TextStyle(
                              fontSize: size.height / 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Text(
                        '\$ ${snapshot.data.docs[0].data()['products'][index]['price']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height / 47),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(size.height / 150),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.all(
                          Radius.circular(size.width / 60),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.add,
                            size: size.height / 40,
                            color: Colors.red,
                          ),
                          Text(
                            'ADD',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Container(
                height: size.height / 23,
                width: size.width,
                child: Text(
                  snapshot.data.docs[0].data()['products'][index]
                      ['description'],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
