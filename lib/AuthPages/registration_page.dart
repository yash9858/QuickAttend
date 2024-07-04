import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:QuickAttend/AuthPages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var visible = true;
  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(mh * 0.025),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height :mh * 0.045),
                  Lottie.asset(
                    'asset/register.json',
                    height: mh * 0.25,
                    fit: BoxFit.cover
                  ),
                  SizedBox(height: mh * 0.025,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: mh * 0.032,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' Now !',
                        style: TextStyle(
                          fontSize: mh * 0.029,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mh * 0.02,),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(mh * 0.025),
                            ),
                            prefixIcon: const Icon(Icons.person_4_outlined),
                            label: const Text('Name'),
                            hintText: 'Enter A Name',
                            filled: true,
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Name must not be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: mh * 0.03),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(mh * 0.025),
                            ),
                            prefixIcon: const Icon(Icons.maps_home_work_outlined),
                            label: const Text('Organization Name'),
                            hintText: 'Enter A Organization Name',
                            filled: true,
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Organization must not be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: mh * 0.03),
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
                        SizedBox(height: mh * 0.03),
                        SizedBox(
                          width: double.infinity,
                          height: mh * 0.06,
                          child: ElevatedButton(
                            onPressed: (){
                              Get.to(()=> const LoginPage());
                            },
                            child: Text(
                              'Create Account',
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
                              "You Already Have An Account ?",
                              style: TextStyle(
                                fontSize: mh * 0.019,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                Get.to(()=> const LoginPage());
                              },
                              child: Text(
                                'Sign In',
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
    );
  }
}
