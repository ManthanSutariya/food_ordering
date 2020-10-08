import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/widgets/rating.dart';

class MoreInfoScreen extends StatelessWidget {
  final String storeName;
  MoreInfoScreen({this.storeName});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Restaurant')
                .where('name', isEqualTo: storeName.toString())
                .get()
                .then((value) => value)
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: Container(
                              child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                snapshot.data.docs[0].data()['images'][0]),
                          )),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              margin: EdgeInsets.all(size.height / 60),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(size.height / 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomWidgets.rating(size: size),
                                      SizedBox(
                                        width: size.width / 50,
                                      ),
                                      Text('3.0'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.009,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width / 80),
                                    child: Text('367 Reviews'),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.share),
                                  Text('Share'),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 70,
                          ),
                          Text(
                            snapshot.data.docs[0].data()['name'],
                            style: TextStyle(
                                fontSize: size.height / 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                            width: size.width,
                            child: ListView.builder(
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.docs[0]
                                  .data()['category']
                                  .length,
                              itemBuilder: (context, index) {
                                return Text(
                                  snapshot.data.docs[0]
                                      .data()['category'][index]
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: size.height / 90,
                          ),
                          Text(
                            'Address :',
                            style: TextStyle(
                                fontSize: size.height / 50,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: size.height / 90,
                          ),
                          Text(
                            'Valentin Mall, Dumas Road Surat',
                            style: TextStyle(
                                fontSize: size.height / 50,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.019),
                          Text(
                            'Timing : ',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Open\'s at : 08:00 AM',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: size.width / 40,
                              ),
                              Text(
                                'Close at : 11:00 PM',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.019),
                          Text(
                            'Popular Dishes ',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            'Veg Whoopler,Cripsy Veg Burger',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.019),
                          Text(
                            'Average Cost ',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.006),
                          Text(
                            '500 for two people (approx) ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.019),
                          Text(
                            'Other Info',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.019),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    maxRadius: size.width / 50,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text('BreakFast'),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    maxRadius: size.width / 50,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text('BreakFast'),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.019),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    maxRadius: size.width / 50,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text('BreakFast'),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    maxRadius: size.width / 50,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text('BreakFast'),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          Divider(
                            color: Colors.black87,
                            height: size.height / 90,
                          ),
                          SizedBox(
                            height: size.height / 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.black12,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(size.height / 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Live\n \bFor',
                              style: TextStyle(
                                  fontSize: size.height / 20,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'Food',
                              style: TextStyle(
                                  fontSize: size.height / 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
