import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class AttendanceDownloadPage extends StatefulWidget {
  const AttendanceDownloadPage({Key? key}) : super(key: key);

  @override
  _AttendanceDownloadPageState createState() => _AttendanceDownloadPageState();
}

class _AttendanceDownloadPageState extends State<AttendanceDownloadPage> {
  String studentId = FirebaseAuth.instance.currentUser!.uid;
  List<Map<String, dynamic>> attendanceData = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('studentId', isEqualTo: studentId)
        .get();

    setState(() {
      attendanceData = snapshot.docs.map((doc) {
        return {
          'date': (doc['date'] as Timestamp).toDate(),
          'isPresent': doc['isPresent'],
          'lecture': doc['lecture'],
        };
      }).toList();
    });
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Attendance Report', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              pw.Text('Date       | Lecture      | Status'),
              pw.SizedBox(height: 8),
              pw.ListView.builder(
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {
                  var entry = attendanceData[index];
                  return pw.Text(
                    '${entry['date'].toString().split(' ')[0]} | ${entry['lecture']} | ${entry['isPresent'] ? 'Present' : 'Absent'}',
                  );
                },
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/attendance_report.pdf');
    await file.writeAsBytes(await pdf.save());

    Share.shareFiles([file.path], text: 'Attendance Report');
  }

  Future<void> _generateCsv() async {
    List<List<String>> rows = [];
    rows.add(['Date', 'Lecture', 'Status']);

    for (var entry in attendanceData) {
      List<String> row = [];
      row.add(entry['date'].toString().split(' ')[0]);
      row.add(entry['lecture']);
      row.add(entry['isPresent'] ? 'Present' : 'Absent');
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/attendance_report.csv');
    await file.writeAsString(csv);

    Share.shareFiles([file.path], text: 'Attendance Report');
  }

  Future<void> _generateExcel() async {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    sheet.appendRow(['Date', 'Lecture', 'Status']);
    for (var entry in attendanceData) {
      sheet.appendRow([
        entry['date'].toString().split(' ')[0],
        entry['lecture'],
        entry['isPresent'] ? 'Present' : 'Absent'
      ]);
    }

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/attendance_report.xlsx');
    file.writeAsBytesSync(excel.save()!);

    Share.shareFiles([file.path], text: 'Attendance Report');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Attendance Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _generatePdf,
              child: const Text('Download PDF'),
            ),
            ElevatedButton(
              onPressed: _generateCsv,
              child: const Text('Download CSV'),
            ),
            ElevatedButton(
              onPressed: _generateExcel,
              child: const Text('Download Excel'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {
                  var entry = attendanceData[index];
                  return ListTile(
                    title: Text(
                        '${entry['date'].toString().split(' ')[0]} - ${entry['lecture']}'),
                    subtitle: Text(entry['isPresent'] ? 'Present' : 'Absent'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
