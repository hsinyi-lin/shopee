import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;


  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key, 
  });

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      default:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange, 
      unselectedFontSize: 12, 
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '蝦拚',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: '商城',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_camera_front_outlined),
          label: '直播',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none_outlined),
          label: '通知',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined),
          label: '我的',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}