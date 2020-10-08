import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SreachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController _searchController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(size.width / 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: TextStyle(
                    fontSize: size.height / 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height / 90,
              ),
              TextField(
                onChanged: (value) {
                  print(value);
                  // print(FirebaseFirestore.instance.collection('Restaurant').where('pro' ,arrayContains: {'name' : 'manthan', 'surname' : 'sutariya'} ).get().then((value) => print(value.docs.length)));
                  // print(FirebaseFirestore.instance.collection('Restaurant').doc().get().then((value) => print(value.reference.get().then((value) => print(value.id)))));
                },
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TextField(
//   decoration: InputDecoration(
//     hintText: 'Restaurant name, cuisine, or a dish...',
//     focusedBorder: OutlineInputBorder(),
//     prefixIcon: Icon(
//       FontAwesome.search,
//       color: Colors.black54,
//       size: size.height / 40,
//     ),
//   ),
// ),
// SizedBox(
//   height: size.height / 50,
// ),
