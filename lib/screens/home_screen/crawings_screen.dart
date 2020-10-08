import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering/screens/storescreen.dart';

class CrawingsScreen extends StatelessWidget {
  final String searchQuery;

  CrawingsScreen({this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
                color: Colors.black54,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width / 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Restaurant Serving Pizza ',
                style: TextStyle(
                    fontSize: size.height * 0.03, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: _getListOfCrawinsRestaurant(
                    size: size, searchQuery: searchQuery),
              ),
            ],
          ),
        ));
  }
}

getLockdownItems({size}) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('Restaurant')
        .where('category', arrayContains: 'burger')
        .get()
        .then((value) => value)
        .asStream(),
    builder: (context, snapshot) {
      return GridView.builder(
        itemCount: snapshot.data.docs.length,
        primary: false,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: size.width / 3, mainAxisSpacing: 0),
        itemBuilder: (context, index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(size.width / 40),
                  height: size.height / 9,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(size.height / 40),
                    ),
                  ),
                  child: Image(
                    image: NetworkImage(
                        snapshot.data.docs[index].data()['logoUrl']),
                  ),
                ),
                Text(snapshot.data.docs[index].data()['name']),
              ]);
        },
      );
    },
  );
}

_getListOfCrawinsRestaurant({size, String searchQuery}) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('Restaurant')
        .where('category', arrayContains: searchQuery.toLowerCase())
        .get()
        .then((value) => value)
        .asStream(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(searchQuery);
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoreScreen(
                      storeName: snapshot.data.docs[index].data()['name'],
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.height / 70, horizontal: size.height / 70),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3.0,
                        spreadRadius: 3.0,
                        offset: Offset(2.0, 2.0))
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(size.height / 40),
                  ),
                ),
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
                            snapshot.data.docs[index].data()['logoUrl'],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.width / 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data.docs[index].data()['name'],
                                style: TextStyle(
                                    fontSize: size.height / 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: size.height / 70,
                              ),
                              Text(
                                snapshot.data.docs[0].data()['category'][0],
                              ),
                              SizedBox(
                                height: size.height / 60,
                              ),
                            ],
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    '\$ ${snapshot.data.docs[index].data()['estimated_price_per_person']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: ' Per Person ',
                                style: TextStyle(color: Colors.black54),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
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
