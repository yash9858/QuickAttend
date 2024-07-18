import 'package:QuickAttend/SubAdmin/sub_admin_home.dart';
import 'package:QuickAttend/Themes/outline_btn.dart';
import 'package:QuickAttend/Student/student_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassSelect extends StatelessWidget {
  final String role;
  const ClassSelect({super.key, required this.role});

  @override
  Widget build(BuildContext context) {

    Future<void> _updateUserClass(String selectedClass) async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'class': selectedClass,
          });
        }
      } catch (e) {
        // Handle error
        print('Failed to update user class: $e');
      }
    }

    var text = [
      'Class I',
      'Class II',
      'Class III',
      'Class IV',
      'Class V',
      'Class VI',
      'Class VII',
      'Class VII',
      'Class IX',
      'Class X',
      'Class XI',
      'Class XII',
    ];
    return Scaffold(
      body: ListView.builder(
        itemCount: text.length,
        itemBuilder: (BuildContext context, int index){
          return SingleChildScrollView(
              child: Column(
                children: [
                  OutlineBtn(
                    onPress: () async {
                      String selectedClass = text[index].toString();
                      await _updateUserClass(selectedClass);
                      if(role == 'Student'){
                        Get.off(()=> BottomNavigator());
                      }
                      else{
                        Get.off(()=> SubAdminHome());
                      }
                    },
                    text: text[index].toString(),
                  ),
                  SizedBox(height: 15,),
                ],
              ));
        },
      ),
    );
  }
}


