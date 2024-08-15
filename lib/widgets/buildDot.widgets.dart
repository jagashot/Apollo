import 'package:flutter/material.dart';

//Building the dots for the top screen indicators

Widget buildDot(int currentIndex, int index, BuildContext context) {
  return Container(
    height: 10,
    width: currentIndex == index ? 30 : 10,
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
  );
}