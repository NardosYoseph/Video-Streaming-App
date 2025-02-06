import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white,
      selectedFontSize: 16,
      items: [
    BottomNavigationBarItem(icon: Icon(Icons.video_collection),label: 'video'),BottomNavigationBarItem(icon: Icon(Icons.notifications),label: "notification")]);
  }
}