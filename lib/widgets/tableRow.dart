import 'package:flutter/material.dart';
import 'package:numbers/utils/constants.dart';

TableRow buildTableRow(String listOfNames) {
    return TableRow(
      children: listOfNames.split(',').map((name) {
        return Container(
          child: Text(
            name,
            style: TextStyle(
                fontSize: 13.0,
                color: greyFontColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          padding: EdgeInsets.only(top: 15.0, left: 10),
        );
      }).toList(),
    );
  }
