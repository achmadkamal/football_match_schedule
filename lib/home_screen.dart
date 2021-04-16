import 'package:flutter/material.dart';
import 'package:football_match_schedule/screens/list_club_screen.dart';
import 'package:football_match_schedule/screens/match_club_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> screenPage = [
    MatchClubScreen(),
    ListClubScreen(),
  ];

  void onTappedBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xffaf60af),
        onTap: onTappedBar,
        items: [
          BottomNavigationBarItem(
            label: 'Match Club',
            icon: Icon(Icons.live_tv_outlined),
          ),
          BottomNavigationBarItem(
            label: 'List Club',
            icon: Icon(Icons.list),
          ),
        ],
      ),
      body: screenPage[selectedIndex],
    );
  }
}
