import 'package:flutter/material.dart';

class SreachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: size.height / 30,
            ),
            TextField(
              onTap: () {},
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
