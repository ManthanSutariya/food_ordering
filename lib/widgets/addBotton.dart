import 'package:flutter/material.dart';
import 'package:food_ordering/screens/provider/provider.dart';
import 'package:get_it/get_it.dart';

var cart = GetIt.instance<Cart>();

Widget getAddToCartBotton(
    {String name,
    String price,
    String storeName,
    String descripion,
    String imageUrl,
    String address,
      String storeLogoUrl,
    size,
    context}) {
  return GestureDetector(
    onTap: () async {
      await cart.addProduct(
          name: name,
          price: price,
          description: descripion,
          imageUrl: imageUrl,
          address: address,
          storeName: storeName);
    },
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
  );
}
