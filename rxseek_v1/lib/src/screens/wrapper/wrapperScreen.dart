import 'package:flutter/material.dart';
import 'package:rxseek_v1/src/routing/router.dart';
import 'package:rxseek_v1/src/screens/home/home_screen.dart';
import 'package:rxseek_v1/src/screens/profile/profile_screen.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  int _selectedIndex = 0;

  final List<String> screenPathOptions = [
    HomeScreen.route,
    ProfileScreen.route
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      GlobalRouter.I.router.go(screenPathOptions.elementAt(_selectedIndex));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    ));
  }
}
