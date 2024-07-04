import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:QuickAttend/AuthPages/forget_password.dart';
import 'package:QuickAttend/AuthPages/registration_page.dart';
import 'package:QuickAttend/User/bottom_navigation_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return GestureDetector(
        child: Scaffold(
            body: Padding(
                padding: EdgeInsets.all(mh * 0.025),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height :mh * 0.05),
                      Lottie.asset(
                          'asset/attendance.json',
                          height: mh * 0.27,
                        ),
                      SizedBox(height: mh * 0.035,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: mh * 0.032,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: mh * 0.001,),
                          Text(
                            ' Back !',
                            style: TextStyle(
                              fontSize: mh * 0.029,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: mh * 0.05,),
                      Form(
                        child: Column(
                          children: [
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
                            SizedBox(height: mh * 0.04),
                            TextFormField(
                              obscureText: visible,
                              obscuringCharacter: '*',
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(mh * 0.025),
                                ),
                                label: const Text('Password'),
                                hintText: 'Enter A Password',
                                filled: true,
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon:Icon(visible ? Icons.visibility : Icons.visibility_off),
                                  onPressed: (){
                                    setState(() {
                                      visible =! visible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Use Proper Password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: mh * 0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: (){
                                      Get.to(()=> const ForgetPassword());
                                    },
                                    child: Text(
                                      'Forget Password?',
                                      style: TextStyle(
                                        fontSize: mh * 0.0185,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: mh * 0.02),
                            SizedBox(
                              width: double.infinity,
                              height: mh * 0.06,
                              child: ElevatedButton(
                                onPressed: (){
                                  Get.offAll(()=> const BottomNavigator());
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: mh * 0.023,
                                  ),),
                              ),
                            ),
                            SizedBox(height: mh * 0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Have An Account ?",
                                  style: TextStyle(
                                    fontSize: mh * 0.019,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: (){
                                    Get.to(()=> const RegisterPage());
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: mh * 0.019,
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
