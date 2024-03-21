import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildTab(String label, Color borderColor,Color color ) {
  return Tab(
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label,
            style: TextStyle(
              color: borderColor,
            ),
          ),
        ],
      ).paddingAll(8),
    ),
  );
}
