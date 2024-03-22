import 'package:assignment/controller/userController.dart';
import 'package:assignment/repo/userRepository.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    getAdress();
    super.initState();
  }

  void getAdress() async {
    userController.address.value =
        await UserRepository().getPlaceName(0.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              onRefresh: () async {
                await userController
                    .fetchUserData(userController.userId.value);
              },
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Obx(
                    () => userController.UserData.isEmpty ||
                            userController.UserData[0].data.length == 0
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: userController.fetchReport.value != ''
                                    ? SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userController
                                                  .fetchReport.value,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const RegisterScreen(),
                                                      ));
                                                },
                                                child: Text(
                                                  'Create New Account',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ))
                                          ],
                                        ),
                                      )
                                    : CircularProgressIndicator()))
                        : Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                          top: 0,
                            child: Container(
                              height: 300.h,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.redAccent,
                        )),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              height: 450.h,
                              width: MediaQuery.of(context).size.width,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(20)
                             ),
                            )),
                        Positioned(
                            child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8.r)),
                                  child: Obx(() => Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Name: ${userController.UserData[0].data[0].fullName.toString()}',
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 25.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                width: 313.w,
                                height: 20.h,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Birthday: ${userController.UserData[0].data[0].dateOfBirth.toString().substring(0, 11)}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color:Colors.white, fontSize: 18.sp,fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                width: 313.w,
                                height: 20.h,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Email: ${userController.UserData[0].data[0].email.toString()}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color:Colors.white, fontSize: 18.sp,fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 60.h,
                              ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Card(
                                     child: Container(
                                       width: 150.w,
                                       height: 150.h,

                                       decoration: BoxDecoration(
                                        // color: Color.fromARGB(255, 232, 230, 230),
                                         borderRadius: BorderRadius.circular(4.r),
                                       ),
                                       child: Align(
                                         alignment: Alignment.center,
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             Icon(userController.UserData[0].data[0].gender.toString().toLowerCase().contains('male')?Icons.boy:
                                             userController.UserData[0].data[0].gender.toString().toLowerCase().contains('female')?Icons.female_outlined:
                                             Icons.person_outlined,size: 55.sp,),
                                             Text(
                                               'Gender: ${userController.UserData[0].data[0].gender}',
                                               textAlign: TextAlign.center,
                                               style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ),
                                   Card(
                                     child: Container(
                                       width: 150.w,
                                       height: 150.h,

                                       decoration: BoxDecoration(
                                         // color: Color.fromARGB(255, 232, 230, 230),
                                         borderRadius: BorderRadius.circular(4.r),
                                       ),
                                       child: Align(
                                         alignment: Alignment.center,
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             Icon(Icons.menu_book,size: 55.sp,),
                                             Text(
                                               'Subject of Interest: ${userController.UserData[0].data[0].subjectCategory != null && userController.UserData[0].data[0].subjectCategory.length != 0 ? userController.UserData[0].data[0].subjectCategory[0] : ''}',
                                               textAlign: TextAlign.center,
                                               style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                width: 313.w,
                                height: 56.h,
                                padding: EdgeInsets.only(left: 10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.redAccent.withOpacity(0.2), // Use red accent color
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined, // Use the location icon from Flutter Icons
                                      color: Colors.black,
                                      size: 26.sp,
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        'Location: ${userController.UserData[0].data[0].latitude}  ${userController.UserData[0].data[0].longitude}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 14.sp, color: Colors.black,fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Spacer(),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 40.h),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const LoginScreen(),
                                          ));
                                    },
                                    child: Container(
                                      width:
                                      MediaQuery.of(context).size.width -
                                          50.w,
                                      height: 44.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(100.r),
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.logout,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              'Sign out',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  )),
            ),
          )),
    );
  }
}
