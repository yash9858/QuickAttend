import 'package:flutter/material.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  String _value='';
  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mh * 0.02),
          child: Column(
            children: [
              SizedBox(height: mh * 0.03,),
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
              SizedBox(height: mh * 0.03,),
              Form(
                child: Column(
                  children: [
                    SizedBox(height: mh * 0.05),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(mh * 0.025),
                        ),
                        prefixIcon: const Icon(Icons.person),
                        label: const Text('Name'),
                        hintText: 'Enter A Name',
                        filled: true,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Nane must not be empty";
                        }
                        else{
                          return "Enter a valid Name";
                        }
                      },
                    ),
                    SizedBox(height: mh * 0.025),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(mh * 0.025),
                        ),
                        prefixIcon: const Icon(Icons.maps_home_work),
                        label: const Text('Address'),
                        hintText: 'Enter A Address',
                        filled: true,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Address must not be empty";
                        }
                          else{
                            return "Address a valid Email";
                          }
                      },
                    ),
                    SizedBox(height: mh * 0.025),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(mh * 0.025),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                        label: const Text('Email'),
                        hintText: 'Enter A Email',
                        filled: true,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Email must not be empty";
                        } else {
                          if (RegExp(
                              r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}"
                          ).hasMatch(val)) {
                            return null;
                          }
                          else{
                            return "Enter a valid Email";
                          }
                        }
                      },
                    ),
                    SizedBox(height: mh * 0.025),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(mh * 0.025),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                        label: const Text('Email'),
                        hintText: 'Enter A Email',
                        filled: true,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Email must not be empty";
                        } else {
                          if (RegExp(
                              r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}"
                          ).hasMatch(val)) {
                            return null;
                          }
                          else{
                            return "Enter a valid Email";
                          }
                        }
                      },
                    ),
                    SizedBox(height: mh * 0.03),
                    Row(
                        children:[
                          Radio(
                            value: "Male",
                            groupValue: _value,
                            onChanged: (value){
                              setState(() {
                                _value = value as String;
                              });
                            },
                          ),
                          const Text('Male', style: TextStyle(fontSize: 18)),
                          Radio(
                            value: "Female",
                            groupValue: _value,
                            onChanged: (value){
                              setState(() {
                                _value = value as String;
                              });
                            },
                          ),
                          const Text('Female', style: TextStyle(fontSize: 18)),
                          Radio(
                            value: "Other",
                            groupValue: _value,
                            onChanged: (value){
                              setState(() {
                                _value = value as String;
                              });
                            },
                          ),
                          const Text('Other', style: TextStyle(fontSize: 18)),
                        ]),
                    SizedBox(height: mh * 0.04),
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
                          onPressed: (){},
                          child: Center(
                            child: Text(
                              'Update Profile',
                              style: TextStyle(
                                fontSize: mh * 0.025,
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}
