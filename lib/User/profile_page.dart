import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:QuickAttend/AuthPages/login_page.dart';
import 'package:QuickAttend/ProfilePage/setting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                      'Yash Mistry',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: mh * 0.028
                      ),
                    ),
                    Text(
                      'Name of organization',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: mh * 0.021
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mh * 0.05,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mh * 0.02),
                child: Column(
                  children: [
                    InkWell(
                          borderRadius: BorderRadius.circular(mh * 0.02),
                          onTap: (){},
                          child: Card(
                            child: ListTile(
                              leading: Container(
                                height: mh * 0.05,
                                width: mh * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(mh * 0.05),
                                ),
                                child: const Icon(Icons.person),
                              ),
                              title: const Text(
                                'My Profile',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                    SizedBox(height: mh * 0.015,),
                    InkWell(
                          borderRadius: BorderRadius.circular(mh * 0.02),
                          onTap: (){},
                          child: Card(
                            surfaceTintColor: Colors.grey[400],
                            child: ListTile(
                              leading: Container(
                                height: mh * 0.05,
                                width: mh * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(mh * 0.05),
                                ),
                                child: const Icon(Icons.download),
                              ),
                              title: const Text(
                                'Download Report',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                    SizedBox(height: mh * 0.015,),
                    InkWell(
                          borderRadius: BorderRadius.circular(mh * 0.02),
                          onTap: (){},
                          child: Card(
                            surfaceTintColor: Colors.grey[400],
                            child: ListTile(
                              leading: Container(
                                height: mh * 0.05,
                                width: mh * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(mh * 0.05),
                                ),
                                child: const Icon(Icons.policy),
                              ),
                              title: const Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                    SizedBox(height: mh * 0.015,),
                    InkWell(
                      borderRadius: BorderRadius.circular(mh * 0.02),
                      onTap: (){},
                      child: Card(
                        surfaceTintColor: Colors.grey[400],
                        child: ListTile(
                          leading: Container(
                            height: mh * 0.05,
                            width: mh * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(mh * 0.05),
                            ),
                            child: const Icon(Icons.help),
                          ),
                          title: const Text(
                            'Help Center',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mh * 0.015,),
                    InkWell(
                      borderRadius: BorderRadius.circular(mh * 0.02),
                      onTap: (){
                        Get.to(()=> SettingsPage());
                      },
                      child: Card(
                        surfaceTintColor: Colors.grey[400],
                        child: ListTile(
                          leading: Container(
                            height: mh * 0.05,
                            width: mh * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(mh * 0.05),
                            ),
                            child: const Icon(Icons.settings),
                          ),
                          title: const Text(
                            'Settings',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mh * 0.05,),
                    Container(
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
                    )
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
