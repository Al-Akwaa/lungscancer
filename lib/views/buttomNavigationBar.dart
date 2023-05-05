import 'package:flutter/material.dart';
import 'package:lungscancer/providers/User_Provider.dart';
import 'package:lungscancer/widgets/custom_button.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [    HomeScreen(),    PhotoScreen(),    NotificationScreen(),    LogoutScreen(),  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar Demo'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        iconSize: 22,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_outlined, color: Colors.black54),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo_outlined, color: Colors.black54),
              label: 'صورة'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none, color: Colors.black54),
              label: 'تقرير'),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout, color: Colors.black54),
              label: 'تسجيل خروج'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}

class PhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Photo Screen'),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notification Screen'),
    );
  }
}

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final userProvider= ref.watch(authUserProvider);
        return Center(
          child:   CustomButton(
            color:   Color.fromARGB(255, 15, 62, 129),
            text: "الخروج بشكل نهائي من هذا الحساب",
            onPressed: () {
              userProvider.logout();
            },
          ),
        );
      },
    );
  }
}
