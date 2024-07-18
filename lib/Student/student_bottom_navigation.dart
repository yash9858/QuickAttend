import 'package:QuickAttend/Student/student_cal.dart';
import 'package:QuickAttend/Student/student_home.dart';
import 'package:flutter/material.dart';
import 'package:QuickAttend/Student/student_profile.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  late PageController _pageController;
  int selectedIndex = 0;
  String studentId = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
    _fetchStudentId();
  }

  Future<void> _fetchStudentId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        studentId = user.uid;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.teal,
          ),
        ),
      );
    }

    final List<Widget> _listOfWidget = [
      const StudentHome(),
      AttendanceCalendar(studentId: studentId),
      const StudentProfile(),
    ];

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
            title: 'Calendar',
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
