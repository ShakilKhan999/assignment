import 'package:assignment/controller/userController.dart';
import 'package:assignment/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({super.key});

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  UserController userController = Get.put(UserController());
  final sDateFormate = "dd/MM/yyyy";
  DateTime _dateTime = DateTime.now();
  bool agreeToTerms = false;
  bool welsh = false;
  bool _correspondInWelsh = false;
  bool isDateSelected = false;
  String? selectedGender;
  String? selectedSubject;
  void _showCupertinoDatePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Color(0xFF5F8B95),
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _dateTime ?? DateTime.now(),
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime(2025),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _dateTime = newDate;
                      isDateSelected = true;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 29.h,
                  ),
                  Text(
                    'Let’s fill up the questions',
                    style: TextStyle(
                      color: Color(0xFF181E29),
                      fontSize: 22.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 29.h,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 313.w,
                        height: 56.h,
                        padding: EdgeInsets.only(
                          left: 16.w,
                        ),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.w, color: Colors.black),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        child: Center(
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showCupertinoDatePicker,
                        child: Container(
                          margin: EdgeInsets.only(top: 15.h),
                          width: 313.w,
                          height: 56.h,
                          padding: EdgeInsets.only(
                              top: 4.h, left: 16.w, bottom: 4.h),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1.w, color: Colors.black),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isDateSelected
                                    ? _formatDate(_dateTime)
                                    : 'Date of Birth',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF0a7bc4),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: 15.h),
                        width: 313.w,
                        height: 56.h,
                        padding:
                            EdgeInsets.only(top: 4.h, left: 16.w, bottom: 4.h),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.w, color: Colors.black),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Choose gender',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 8.0.w,
                                  top: 8.h,
                                  bottom: 8.h,
                                  left: 8.w),
                              child: DropdownButton<String>(
                                value: selectedGender,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedGender = newValue;
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF0a7bc4),
                                ),
                                iconSize: 24.sp,
                                underline: Container(),
                                items: <String>[
                                  'Male',
                                  'Female',
                                  'Others',
                                  'Prefer not say'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: 15.h),
                        width: 313.w,
                        height: 56.h,
                        padding:
                            EdgeInsets.only(top: 4.h, left: 16.w, bottom: 4.h),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.w, color: Colors.black),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Subject of Interest',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 8.0.w,
                                  top: 8.h,
                                  bottom: 8.h,
                                  left: 8.w),
                              child: DropdownButton<String>(
                                value: selectedSubject,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSubject = newValue;
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF0a7bc4),
                                ),
                                iconSize: 24.sp,
                                underline: Container(),
                                items: <String>[
                                  'Mathematics',
                                  'Science',
                                  'History',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 313.w,
                        height: 30.h,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 32.w,
                              height: 32.h,
                              padding: EdgeInsets.all(4.sp),
                              child: Checkbox(
                                activeColor: Color(0xFF0a7bc4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.r)),
                                value: agreeToTerms,
                                onChanged: (newValue) {
                                  setState(() {
                                    agreeToTerms = newValue ?? false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Agree to marking updates.',
                              style: TextStyle(
                                color: Color(0xFF181E29),
                                fontSize: 15.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 313.w,
                        height: 30.h,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 32.w,
                              height: 32.h,
                              padding: EdgeInsets.all(4.sp),
                              child: Checkbox(
                                activeColor: Color(0xFF0a7bc4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.r)),
                                value: welsh,
                                onChanged: (newValue) {
                                  setState(() {
                                    welsh = newValue ?? false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Correspond in Welsh',
                              style: TextStyle(
                                color: Color(0xFF181E29),
                                fontSize: 15.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.h),
                      child: InkWell(
                        onTap: () {
                          if (calculateDifferenceInYears(
                                  DateTime.now(), _dateTime) <
                              16) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Age should be 16 year'),
                              ),
                            );
                            return;
                          }
                          userController.updateUser(
                              userId: userController.userId.value ?? "",
                              fullName: nameController.text,
                              dateOfBirth: _dateTime.toString(),
                              gender: selectedGender ?? 'N/A',
                              agreeToMarketing: agreeToTerms,
                              correspond: welsh,
                              updatedAt: DateTime.now().toString(),
                              sub: [
                                selectedSubject == null ? '' : selectedSubject!
                              ]).then((value) async {
                            await userController
                                .fetchUserData(userController.userId.value);
                            if (value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardScreen(),
                                  ));
                            }
                          });
                        },
                        child: Container(
                          width: 200.w,
                          height: 44.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFF0a7bc4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int calculateDifferenceInYears(DateTime dateTime1, DateTime dateTime2) {
    int yearsDiff = dateTime2.year - dateTime1.year;

    // Check if we need to subtract 1 if the second date hasn't reached the same month and day yet.
    if (dateTime2.month < dateTime1.month ||
        (dateTime2.month == dateTime1.month && dateTime2.day < dateTime1.day)) {
      yearsDiff--;
    }
    return yearsDiff.abs();
  }
}
