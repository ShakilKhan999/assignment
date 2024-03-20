import 'package:assignment/controller/userController.dart';
import 'package:assignment/repo/userRepository.dart';
import 'package:assignment/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserController userController=Get.put(UserController());
  @override
  void initState() {
getAdress();
    super.initState();
  }
  void getAdress() async{
    userController.address.value=await UserRepository().getPlaceName(0.0, 0.0);
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Color(0xFF0a7bc4)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Container(
                          width: 104.w,
                          height: 104.h,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(
                              side: BorderSide(
                                width: 3,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0xFFE7E9EB),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Obx(()=>Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:170.w,
                            child: Text(
                              'First Name: ${userController.UserData[0].data[0].fullName.toString().contains(' ')?
                              userController.UserData[0].data[0].fullName.toString().split(' ')[0]:
                              userController.UserData[0].data[0].fullName.toString()}',
                              overflow: TextOverflow.ellipsis,
                              style:
                              TextStyle(fontSize: 20.sp, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(
                            width:170.w,
                            child: Text(
                              'Last Name: ${userController.UserData[0].data[0].fullName.toString().contains(' ')?
                              userController.UserData[0].data[0].fullName.toString().split(' ')[1]:
                              userController.UserData[0].data[0].fullName.toString()}',
                              overflow: TextOverflow.ellipsis,
                              style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 313.w,
                  height: 56.h,
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 232, 230, 230),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Date of Birth: ${userController.UserData[0].data[0].dateOfBirth.toString().substring(0,11)}',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 313.w,
                  height: 56.h,
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 232, 230, 230),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email: ${userController.UserData[0].data[0].email}',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 313.w,
                  height: 56.h,
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 232, 230, 230),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Gender: ${userController.UserData[0].data[0].gender}',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 313.w,
                  height: 56.h,
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 232, 230, 230),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Subject of Interest: ${userController.UserData[0].data[0].subjectCategory!=null && userController.UserData[0].data[0].subjectCategory.length!=0?
                          userController.UserData[0].data[0].subjectCategory[0]:''}',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 313.w,
                  height: 56.h,
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 232, 230, 230),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Location: ${userController.UserData[0].data[0].latitude}  ${userController.UserData[0].data[0].longitude}',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40.h),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50.w,
                        height: 44.h,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFF0a7bc4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
          )),
    );
  }
}
