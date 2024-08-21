import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class BuildRecordView extends StatefulWidget {
  const BuildRecordView({super.key});

  @override
  _BuildRecordViewState createState() => _BuildRecordViewState();
}

class _BuildRecordViewState extends State<BuildRecordView> {

  @override
  Widget build(BuildContext context) {
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
          AvatarGlow(
            glowCount: 3,
            glowRadiusFactor: 0.3,
            //add state to the widget, turn off the animation when in another view
            animate: true,
            //----------------------------------------------------------------
            child: GestureDetector(
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
          ),
        ],
      ),
    );
  }
}
