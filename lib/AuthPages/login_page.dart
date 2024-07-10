import 'package:QuickAttend/AuthPages/utils.dart';
import 'package:QuickAttend/Student/student_home.dart';
import 'package:QuickAttend/SubAdmin/sub_admin_home.dart';
import 'package:QuickAttend/SuperAdmin/super_admin_home.dart';
import 'package:QuickAttend/Themes/text_box_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:QuickAttend/AuthPages/forget_password.dart';
import 'package:QuickAttend/AuthPages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool visible = true;
  bool loading = false;
  bool check = true;

  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() async {
    setState(() {
      loading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );

      DocumentSnapshot userDoc = await firestore.collection('users').doc(userCredential.user!.uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        Utils().toastMessage('Welcome, ${userData['email']}!');
        if (userData['role'] == 'SuperAdmin') {
          Get.to(() => const SuperAdminHome());
        } else if (userData['role'] == 'Teacher') {
          Get.to(() => const SubAdminHome());
        } else if (userData['role'] == 'Student') {
          Get.to(() => const StudentHome());
        }
      } else {
        Utils().toastMessage('No user found');
      }
    } catch (error) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var mh = screenSize.height;
    var mw = screenSize.width;
    var isTablet = mw > 600;

    return GestureDetector(
        child: Scaffold(
            body: Padding(
                padding: EdgeInsets.all(isTablet ? mw * 0.05 : mh * 0.025),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: isTablet ? mh * 0.08 : mh * 0.045),
                      Lottie.asset(
                        'asset/attendance.json',
                        height: isTablet ? mh * 0.45 : mh * 0.25,
                      ),
                      SizedBox(height: isTablet ? mh * 0.04 : mh * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: isTablet ? mh * 0.05 : mh * 0.032,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: isTablet ? mh * 0.002 : mh * 0.001),
                          Text(
                            ' Back !',
                            style: TextStyle(
                              fontSize: isTablet ? mh * 0.05 : mh * 0.029,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isTablet ? mh * 0.06 : mh * 0.045),
                      Form(
                        key: _formField,
                        child: Column(
                          children: [
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
                                  if (RegExp(r"^[a-zA-Z0-9]+[^#$%&*]+[a-zA-Z0-9]+@[a-z]+\.[a-z]{2,3}")
                                      .hasMatch(val)) {
                                    return null;
                                  } else {
                                    return "Enter a valid Email";
                                  }
                                }
                              },
                            ),
                            SizedBox(height: isTablet ? mh * 0.05 : mh * 0.03),
                            TextFormField(
                              controller: passwordController,
                              obscureText: visible,
                              obscuringCharacter: '*',
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      isTablet ? mw * 0.03 : mh * 0.025),
                                ),
                                label: const Text('Password'),
                                hintText: 'Enter a Password',
                                filled: true,
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(visible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      visible = !visible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Use Proper Password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: isTablet ? mh * 0.02 : mh * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: check,
                                        onChanged: (value) {
                                          setState(() {
                                            check = value!;
                                          });
                                        }),
                                    Text(
                                      'Remember Me',
                                      style: TextStyle(
                                        fontSize:
                                        isTablet ? mh * 0.05 : mh * 0.0185,
                                      ),
                                    )
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(() => const ForgetPassword());
                                    },
                                    child: Text(
                                      'Forget Password?',
                                      style: TextStyle(
                                        fontSize:
                                        isTablet ? mh * 0.05 : mh * 0.0185,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(height: isTablet ? mh * 0.04 : mh * 0.025),
                            Btn(
                              text: 'Login',
                              onTap: () {
                                if (_formField.currentState!.validate()) {
                                  login();
                                }
                              },
                            ),
                            SizedBox(height: isTablet ? mh * 0.04 : mh * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    height: 1.5,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  'Login With',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                    isTablet ? mh * 0.05 : mh * 0.023,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    height: 1.5,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: isTablet ? mh * 0.04 : mh * 0.025),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GoogleAuthButton(
                                  onPressed: () {},
                                  style: AuthButtonStyle(
                                    buttonType: AuthButtonType.icon,
                                  ),
                                ),
                                FacebookAuthButton(
                                  onPressed: () {},
                                  style: AuthButtonStyle(
                                      buttonType: AuthButtonType.icon,
                                      iconType: AuthIconType.secondary),
                                ),
                                AppleAuthButton(
                                  onPressed: () {},
                                  style: AuthButtonStyle(
                                      buttonType: AuthButtonType.icon),
                                ),
                              ],
                            ),
                            SizedBox(height: isTablet ? mh * 0.05 : mh * 0.025),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Have An Account?",
                                  style: TextStyle(
                                    fontSize:
                                    isTablet ? mh * 0.05 : mh * 0.019,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => const RegisterPage());
                                  },
                                  child: Text(
                                    'Sign Up',
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
        )
    );
  }
}
