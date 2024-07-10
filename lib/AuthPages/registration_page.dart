import 'package:QuickAttend/AuthPages/utils.dart';
import 'package:QuickAttend/Themes/text_box_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:QuickAttend/AuthPages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var valueChoose;
  List listItem = [
    'Student',
    'Teacher'
  ];
  bool loading = false;
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool visible = true;

  final firestore = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  Future<void> signUp() async {
    if (_formField.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        String phone = phoneController.text.toString();
        QuerySnapshot phoneQuery = await firestore.where('phone', isEqualTo: phone).get();
        if (phoneQuery.docs.isNotEmpty) {
          Utils().toastMessage('Phone number already registered');
          setState(() {
            loading = false;
          });
          return;
        }

        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        String name = nameController.text.toString();
        String email = emailController.text.toString();
        String id = userCredential.user!.uid;
        await firestore.doc(id).set({
          'name': name,
          'email': email,
          'phone': phone,
          'role': valueChoose!,
        });

        Utils().toastMessage('Success');
        Get.off(() => const LoginPage());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Utils().toastMessage('Email already registered');
        } else {
          Utils().toastMessage('Failed to register');
        }
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mh = screenSize.height;
    var mw = screenSize.width;
    var isTablet = mw > 600;

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(isTablet ? mw * 0.05 : mh * 0.025),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: isTablet ? mh * 0.08 : mh * 0.01),
                  Lottie.asset(
                      'asset/register.json',
                      height: isTablet ? mh * 0.35 : mh * 0.23,
                      fit: BoxFit.cover
                  ),
                  SizedBox(height: isTablet ? mh * 0.04 : mh * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register ',
                        style: TextStyle(
                          fontSize: isTablet ? mh * 0.05 : mh * 0.032,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Now!',
                        style: TextStyle(
                          fontSize: isTablet ? mh * 0.05 : mh * 0.029,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? mh * 0.03 : mh * 0.02),
                  Form(
                    key: _formField,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(isTablet ? mw * 0.03 : mh * 0.025),
                            ),
                            prefixIcon: const Icon(Icons.person_4_outlined),
                            label: const Text('Name'),
                            hintText: 'Enter a Name',
                            filled: true,
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Name must not be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: isTablet ? mh * 0.05 : mh * 0.02),
                        TextBoxBtn(
                          prefix: Icon(Icons.email_outlined),
                          label: 'Email',
                          hint: 'Enter A Email',
                          controller: emailController,
                          keyboard: TextInputType.emailAddress,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Email must not be empty";
                            } else {
                              if (RegExp(
                                  r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                  .hasMatch(val)) {
                                return null;
                              } else {
                                return "Enter a valid Email";
                              }
                            }
                          },
                        ),
                        SizedBox(height: isTablet ? mh * 0.05 : mh * 0.02),
                        TextBoxBtn(
                          prefix: Icon(Icons.phone_outlined),
                          label: 'Phone No',
                          hint: 'Enter a Phone No',
                          controller: phoneController,
                          keyboard: TextInputType.phone,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Phone No must not be empty";
                            } else if (val.length != 10) {
                              return "Phone No must be 10 digits";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: isTablet ? mh * 0.05 : mh * 0.02),
                        TextFormField(
                          controller: passwordController,
                          obscureText: visible,
                          obscuringCharacter: '*',
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(isTablet ? mw * 0.03 : mh * 0.025),
                            ),
                            label: const Text('Password'),
                            hintText: 'Enter a Password',
                            filled: true,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(visible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return 'Use Proper Password';
                            } else if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: isTablet ? mh * 0.05 : mh * 0.02),
                        Padding(
                            padding: EdgeInsets.all(mh * 0.001),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: mh * 0.02),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(mh * 0.02),
                              ),
                              child: DropdownButtonFormField(
                                hint: Text('Select Item:'),
                                isExpanded: true,
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                value: valueChoose,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChoose = newValue;
                                  });
                                },
                                items: listItem.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a role';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        SizedBox(height: isTablet ? mh * 0.05 : mh * 0.025),
                        Btn(
                          text: 'Create Account',
                          onTap: () {
                            signUp();
                          },
                        ),
                        SizedBox(height: isTablet ? mh * 0.05 : mh * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You Already Have An Account?",
                              style: TextStyle(
                                fontSize: isTablet ? mh * 0.05 : mh * 0.019,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => const LoginPage());
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: isTablet ? mh * 0.05 : mh * 0.019,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Theme.of(context).primaryColor,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
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
