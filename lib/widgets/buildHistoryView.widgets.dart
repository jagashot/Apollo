import 'package:apollo_poc/widgets/historyitem.widgets.dart';
import 'package:flutter/material.dart';

Widget buildHistoryView() {
  // History View for the first page
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 15,
    ),
    child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  bottom: 20,
                ),
                child: const Text(
                  'History',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
              HistoryItem(),
            ],
          ),
        ),
      ],
    ),
  );
}