import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class CurrentUser extends ChangeNotifier {
  User currentUser;
  Future<void> userSession;
  getUser({user}) {
    currentUser = user;
     userSession = FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    notifyListeners();
  }

  updateUser({String displayName, String profileUrl}) {
    currentUser.updateProfile(displayName: displayName, photoURL: profileUrl);
    notifyListeners();
  }

  get userEmail => currentUser == null ? ' -' : currentUser.email;

  get userName => currentUser == null ? ' -' : currentUser.displayName;

  get userProfile => currentUser == null ? ' -' : currentUser.photoURL;

  SignOut() async {
    await FirebaseAuth.instance.signOut();
    print('sign out success');
    currentUser = null;
    notifyListeners();
  }
}

class productModel {
  final String name;
  final String price;
  final String storeName;
  final String description;
  final String imageUrl;

  productModel(
      this.name, this.price, this.storeName, this.description, this.imageUrl);
}

class Cart extends ChangeNotifier {
  List cart = [];
  final _controller = StreamController.broadcast();
  get controllerOut => _controller.stream.asBroadcastStream();
  get controllerIn => _controller.sink;


  int get cartLength => cart.length;

  get cartProduct => cart;

  get getStoreName => cart[0]['storeName'];

  get getProductName => cart.forEach((element) {
        return element['name'];
      });
    getStoreLogo()async{
    return await FirebaseFirestore.instance
        .collection('Restaurant')
        .where('name', isEqualTo: getStoreName)
        .get()
        .then((value) => value.docs[0].data()['logoUrl']);
  }
  verifyCart(){
    print(cart[0]['name']);
    print(cart[0]['price']);
    print(cart[0]['description']);
  }

  addProduct({
    String name,
    String price,
    String storeName,
    String description,
    String imageUrl,
    String address,
    String storeImageUrl,
  }) {
    Map< String , String > data = {};

    if (cart.isEmpty) {
      data.clear();
      data.addAll({
        'name': name,
        'price': price,
        'storeName': storeName,
        'description': description,
        'imageUrl': imageUrl,
        'address' : address,
      });

      cart.add(data);
      controllerIn.add(data);

      notifyListeners();
    }

    if (cart.isNotEmpty && storeName == getStoreName.toString()) {
      data.clear();

      data.addAll({
        'name': name,
        'price': price,
        'storeName': storeName,
        'description': description,
        'imageUrl': imageUrl,
        'address' : address,
      });

      cart.add(data);
    } else {
      print('you cant add product from multiple store');
    }

    print(cart);
    print('ddddddddddddddddddddddddddddddddddddddddddddd');

    cart.isNotEmpty ?? verifyCart();

    notifyListeners();

  }
}
