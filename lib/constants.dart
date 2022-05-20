import 'package:flutter/material.dart';

// Colors that we use in our app
const kPrimaryColor = Color.fromARGB(255, 76, 175, 80);
const kTextColor = Color.fromARGB(255, 11, 12, 11);
const kBackgroundColor = Color.fromARGB(255, 255, 255, 255);

const double kDefaultPadding = 20.0;

class CustomWidgets {
  static TextStyle instructionTextStyle(BuildContext context) {
    return const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18);
  }

  static Widget titleText(BuildContext context, String textData) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding / 4),
          child: Text(
            textData,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.only(right: kDefaultPadding / 4),
            height: 7,
            color: kPrimaryColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
