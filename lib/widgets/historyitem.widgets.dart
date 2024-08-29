import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  final String songTitle;

  const HistoryItem({Key? key, required this.songTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: Colors.white.withOpacity(0.15), // Background color with transparency
        borderRadius: BorderRadius.circular(15),
        elevation: 5,
        child: ListTile(
          minTileHeight: 100,
          onTap: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            songTitle,
            style: const TextStyle(
              color: Colors.black87, // Changed text color for better contrast
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(
            Icons.file_open,
            color: Colors.black87, // Changed icon color for better contrast
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.1),
            child: Icon(
              Icons.music_note,
              color: Colors.black87, // Changed icon color for better contrast
            ),
          ),
        ),
      ),
    );
  }
}
