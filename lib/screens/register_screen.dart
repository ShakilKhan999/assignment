import 'package:assignment/controller/userController.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/screens/question_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  UserController userController = Get.put(UserController());
  final IconData iconData = Icons.visibility;
  bool activeConnection = false;
  bool visiblepass = false;
  bool status = false;
  String errMsg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Image.asset(
                    'images/logo.png',
                    height: 150.h,
                    width: 250.w,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF0a7bc4), width: 1.2)),
                            prefixIcon: Icon(Icons.mail_outline,
                                color: Color(0xFF0a7bc4)),
                            labelText: 'Email',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.2)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.2)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // SizedBox(
                      //   height: 50.h,
                      //   child: TextField(
                      //     controller: phoneController,
                      //     decoration: const InputDecoration(
                      //       focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //               color: Color(0xFF0a7bc4), width: 1.2)),
                      //       prefixIcon: Icon(Icons.phone_iphone_sharp,
                      //           color: Color(0xFF0a7bc4)),
                      //       labelText: 'Phone',
                      //       enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //               color: Colors.black, width: 1.2)),
                      //       border: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //               color: Colors.black, width: 1.2)),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      SizedBox(
                        height: 50.h,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !visiblepass,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: Color(0xFF0a7bc4),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF0a7bc4), width: 1.2)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.2)),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.2)),
                              suffixIcon: visiblepass
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          visiblepass
                                              ? visiblepass = false
                                              : visiblepass = true;
                                        });
                                      },
                                      icon: const Icon(Icons.visibility,
                                          color: Color(0xFF0a7bc4)))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          visiblepass
                                              ? visiblepass = false
                                              : visiblepass = true;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.visibility_off,
                                        color: Color(0xFF0a7bc4),
                                      )),
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () async {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Please fill up email and password fields.'),
                              ),
                            );
                          } else {
                            await userController
                                .createUser(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) {
                              if (value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QuestionForm(),
                                    ));
                              }
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF0a7bc4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.h),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Color(0xFF181E29),
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFF1D4ED8),
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
