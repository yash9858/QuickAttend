import 'package:QuickAttend/ProfilePage/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:QuickAttend/AuthPages/login_page.dart';
import 'package:QuickAttend/ProfilePage/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {

  var Name = ['My Profile', 'Download Report', 'Privacy Policy', 'Help Center', 'Settings'];
  var icon = [Icons.person, Icons.download, Icons.policy, Icons.help, Icons.settings];
  var Page = [MyProfile(),SettingsPage(),SettingsPage(),SettingsPage(),SettingsPage()];

  String studentName = '';
  String studentClass = '';


  void initState(){
    super.initState();
    _fetchStudentData();
  }

  Future<void> _fetchStudentData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        studentName = userDoc['name'];
        studentClass = userDoc['class'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Scaffold(
        body : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: mh * 0.05),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius : mh * 0.075,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(mh * 0.07),
                              child: Image.asset(
                                'asset/logo.jpg',
                                fit : BoxFit.cover,
                              ),
                            )
                        ),
                        Positioned(
                            left: mh * 0.1,
                            bottom: mh * 0.0003,
                            child: CircleAvatar(
                              child : IconButton(
                                icon: const Icon(Icons.camera_alt_outlined),
                                onPressed: (){},
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: mh * 0.01,),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          studentName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: mh * 0.028
                          ),
                        ),
                        Text(
                          studentClass,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontSize: mh * 0.021
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: mh * 0.04,),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: Name.length,
                    itemBuilder: (context, int index){
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: mh * 0.02),
                        child: Column(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(mh * 0.02),
                              onTap: (){
                                Get.to(()=> Page[index]);
                              },
                              child: Card(
                                child: ListTile(
                                  leading: Container(
                                    height: mh * 0.05,
                                    width: mh * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(mh * 0.05),
                                    ),
                                    child: Icon(icon[index]),
                                  ),
                                  title: Text(
                                    Name[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mh * 0.01,),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: mh * 0.03,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mh * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.lerp(
                            Border.all(),
                            Border.all(color: Colors.teal),
                            BorderSide.strokeAlignOutside
                        ),
                        borderRadius: BorderRadius.circular(mh * 0.025),
                      ),
                      child: TextButton(
                          onPressed: (){
                            Get.off(()=> const LoginPage());
                          },
                          child: Center(
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                fontSize: mh * 0.025,
                              ),
                            ),
                          )
                      ),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}