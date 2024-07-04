import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool visiblePass = true;
  bool visibleConfirm = true;

  @override
  Widget build(BuildContext context) {
    var mh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
              "Forget Password",
              style: TextStyle(
                  fontSize: 20
              )
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Form(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: mh * 0.06, horizontal: mh * 0.025),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
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
                        }
                        else {
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
                      controller: passwordController,
                      obscureText: visiblePass,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(mh * 0.025),
                        ),
                        label: const Text('New Password'),
                        hintText: 'New Password',
                        filled: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon:Icon(visiblePass ? Icons.visibility : Icons.visibility_off),
                          onPressed: (){
                            setState(() {
                              visiblePass =! visiblePass;
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
                    SizedBox(height: mh * 0.04),
                    TextFormField(
                      obscureText: visibleConfirm,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(mh * 0.025),
                        ),
                        label: const Text('Confirm Password'),
                        hintText: 'Confirm Password',
                        filled: true,
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                          icon:Icon(visibleConfirm ? Icons.visibility : Icons.visibility_off),
                          onPressed: (){
                            setState(() {
                              visibleConfirm =! visibleConfirm;
                            });
                          },
                        ),
                      ),
                      validator: (value){
                        if (value!.isEmpty) {
                          return "Enter Confirm Password ";
                        }
                        else if(value != passwordController.text){
                          return "Passwords Do Not Match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: mh *0.06),
                    SizedBox(
                      width: double.infinity,
                      height: mh * 0.06,
                      child: ElevatedButton(
                        onPressed: (){},
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: mh * 0.024,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}

