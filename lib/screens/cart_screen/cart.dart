import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/screens/provider/provider.dart';
import 'package:food_ordering/widgets/addBotton.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(size.width / 35),
          child: GetIt.instance.get<Cart>().cart.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Restaurant')
                        .where('name', isEqualTo: GetIt.instance.get<Cart>().getStoreName)
                        .get()
                        .then((value) => value)
                        .asStream(),
                    builder: (context, snapshot) {
                      return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.height / 45)),
                                child: Container(
                                  height: size.height / 8.5,
                                  width: size.width / 4.4,
                                  // color: Colors.blueAccent,
                                  child: Image(image: NetworkImage(snapshot.data.docs[0].data()['logoUrl']),),
                                ),
                              ),
                              SizedBox(
                                width: size.width / 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    GetIt.instance.get<Cart>().cart[0]
                                    ['storeName'] ??
                                        '',
                                    style: TextStyle(
                                      fontSize: size.height / 39,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 60,
                                  ),
                                  Text(
                                    GetIt.instance.get<Cart>().cart[0]['address'] ??
                                        '',
                                    style: TextStyle(
                                        fontSize: size.height / 50,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          AspectRatio(
                            aspectRatio: 4,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.verified_user),
                                        Text(
                                          GetIt.instance.get<Cart>().cart[0]
                                          ['name'] ??
                                              '',
                                          style: TextStyle(
                                              fontSize: size.height / 45,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height / 40,
                                    ),
                                    Text('description')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: size.height / 25,
                                      width: size.width / 4.5,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black26),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '1',
                                            style: TextStyle(
                                              fontSize: size.height / 40,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width / 40,
                                    ),
                                    Text(
                                      '\$ 3.8',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.height / 50),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height / 14,
                          ),
                          Text(
                            'Bill Detail',
                            style: TextStyle(
                                fontSize: size.height / 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: size.height / 60,
                          ),
                          AspectRatio(
                            aspectRatio: 3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'item totall',
                                      style: TextStyle(
                                          fontSize: size.height / 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      '\$ 3.8',
                                      style: TextStyle(
                                          fontSize: size.height / 45,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height / 60,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Taxes & Charges',
                                      style: TextStyle(
                                          fontSize: size.height / 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      '\$ 1.0',
                                      style: TextStyle(
                                          fontSize: size.height / 45,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black12,
                                  thickness: size.width / 140,
                                  endIndent: size.width / 10,
                                  indent: size.width / 10,
                                ),
                                SizedBox(
                                  height: size.height / 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Grand Totall',
                                      style: TextStyle(
                                          fontSize: size.height / 37,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '\$ 4.8',
                                      style: TextStyle(
                                          fontSize: size.height / 37,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: size.height / 18,
                            child: RaisedButton(
                              onPressed: () {},
                              splashColor: Colors.white,
                              elevation: size.height / 30,
                              color: Colors.redAccent,
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                    fontSize: size.height / 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    ),
                )
              : Center(
                  child: Text(
                    'Add Something from store',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: size.height / 14,
                        color: Colors.black12),
                  ),
                ),
        ),
      ),
    );
  }
}
