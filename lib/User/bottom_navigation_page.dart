import 'package:flutter/material.dart';
import 'package:QuickAttend/User/calendar_bottom.dart';
import 'package:QuickAttend/User/home_page_user.dart';
import 'package:QuickAttend/User/profile_page.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';


class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  late PageController _pageController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }
  final List<Widget> _listOfWidget = <Widget>[
    const HomeUser(),
    const CalendarBottom(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.calendar_month_rounded,
            title: 'Calender',
          ),
          BarItem(
            icon: Icons.person,
            title: 'Profile',
          ),
        ],
      ),
    );
  }
}
