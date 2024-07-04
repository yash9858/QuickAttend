import 'package:flutter/material.dart';
class CalendarBottom extends StatefulWidget {
  const CalendarBottom({super.key});

  @override
  State<CalendarBottom> createState() => _CalendarBottomState();
}

class _CalendarBottomState extends State<CalendarBottom> {
  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(mh * 0.025),
          child: Column(

          )
        )
      ),
    );
  }
}
