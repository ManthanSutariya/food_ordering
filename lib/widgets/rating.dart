import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter/material.dart';

class CustomWidgets {
  static rating({size, Function updateRating}) {
    return RatingBar(
      initialRating: 3,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: size.height / 60,
      ratingWidget: RatingWidget(
        full: Icon(
          FontAwesome5.heart,
          color: Colors.red,
        ),
        //_image('assets/heart.png'),
        half: Icon(
          FontAwesome5.heart,
          color: Colors.white,
        ),
        //_image('assets/heart_half.png'),
        empty: Icon(
          FontAwesome5.heart,
          color: Colors.black12,
        ), //_image('assets/heart_border.png'),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {
        updateRating(rating);
      },
    );
  }
}
