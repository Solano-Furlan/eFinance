import 'package:flutter/material.dart';

Widget amortizationResults(String name, String value) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 19,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 19,
            ),
          ),
        ],
      ),
    ),
  );
}

