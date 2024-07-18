import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceCalendar extends StatefulWidget {
  final String studentId;
  AttendanceCalendar({required this.studentId});

  @override
  _AttendanceCalendarState createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  late Map<DateTime, bool> _attendanceData;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _attendanceData = {};
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = null;
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('studentId', isEqualTo: widget.studentId)
        .get();

    setState(() {
      _attendanceData = {
        for (var doc in snapshot.docs)
          (doc['date'] as Timestamp).toDate(): doc['isPresent'] as bool
      };
    });
  }

  Future<void> _markPresent(DateTime date) async {
    await FirebaseFirestore.instance.collection('attendance').add({
      'studentId': widget.studentId,
      'date': date,
      'isPresent': true,
    });

    setState(() {
      _attendanceData[date] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: mh * 0.04),
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, events) {
                if (_attendanceData.containsKey(date)) {
                  bool isPresent = _attendanceData[date]!;
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isPresent ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          if (_selectedDay != null) _buildAttendanceDetails(_selectedDay!),
          const SizedBox(height: 8.0),
          _buildWeekSummary(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildAttendanceList()),
        ],
      ),
    );
  }

  Widget _buildAttendanceDetails(DateTime date) {
    bool? isPresent = _attendanceData[date];
    bool isToday = isSameDay(date, DateTime.now());

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date: ${date.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Status: ${isPresent == true ? 'Present' : 'Absent'}",
            style: TextStyle(fontSize: 16.0),
          ),
          if (isPresent != null && !isPresent && isToday)
            ElevatedButton(
              onPressed: () => _markPresent(date),
              child: Text('Mark as Present'),
            ),
        ],
      ),
    );
  }

  Widget _buildAttendanceList() {
    List<DateTime> dates = _attendanceData.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      itemCount: dates.length,
      itemBuilder: (context, index) {
        DateTime date = dates[index];
        bool isPresent = _attendanceData[date]!;
        return ListTile(
          title: Text(
            "Date: ${date.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 16.0),
          ),
          subtitle: Text(
            "Status: ${isPresent ? 'Present' : 'Absent'}",
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: !isPresent && isSameDay(date, DateTime.now())
              ? ElevatedButton(
            onPressed: () => _markPresent(date),
            child: Text('Mark as Present'),
          )
              : null,
        );
      },
    );
  }

  Widget _buildWeekSummary() {
    DateTime today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    List<DateTime> weekDates =
    List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "This Week's Attendance",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ...weekDates.map((date) {
          bool? isPresent = _attendanceData[date];
          return ListTile(
            title: Text(
              "Date: ${date.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 16.0),
            ),
            subtitle: Text(
              "Status: ${isPresent == true ? 'Present' : 'Absent'}",
              style: TextStyle(fontSize: 16.0),
            ),
          );
        }).toList(),
      ],
    );
  }
}
