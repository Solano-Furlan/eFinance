import 'package:flutter/material.dart';

Widget results(String name, String value, BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  double responsiveHeight(pixels) {
    return height * (pixels / 725);
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
        width: width * 0.7 - responsiveHeight(60),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: responsiveHeight(19),
            ),
          ),
        ),
      ),
      Container(
        width: width * 0.3,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.white,
              fontSize: responsiveHeight(19),
            ),
          ),
        ),
      ),
    ],
  );
}
