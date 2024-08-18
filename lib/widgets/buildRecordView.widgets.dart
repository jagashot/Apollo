
import 'package:flutter/material.dart';

Widget buildRecordView(BuildContext context) {
  //Record View for the second page
  return  Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Tap to Record',
          style: TextStyle(color: Colors.white, fontSize: 20, decoration: TextDecoration.none),
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () => print("Yea!"),
          child: Material(
            shape: const CircleBorder(),
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(40),
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(image:AssetImage('assets/photos/main_btn.png'), 
                fit: BoxFit.fill
                ),
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 140, 80, 182),
              ),
              child: const Icon(
                Icons.mic,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}