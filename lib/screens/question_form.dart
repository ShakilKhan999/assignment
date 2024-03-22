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
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Personal Details',
                    style: TextStyle(
                      color: Color(0xFF181E29),
                      fontSize: 22.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedGender='Female';
                                });
                              },
                              child: Container(
                                height: 70.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color:selectedGender=='Female'?
                                  Colors.amber:Colors.black,),
                                  color:selectedGender=='Female'?
                                  Colors.amber.withOpacity(0.1):
                                  Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.female_outlined,size: 50.sp,
                                        color:selectedGender=='Female'?
                                        Colors.amber:Colors.black),
                                    Text(
                                      'Female',
                                      style: TextStyle(
                                         color:selectedGender=='Female'?
                                      Colors.amber:Colors.black,
                                        fontSize: 18.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectedGender='Male';
                                });
                              },
                              child: Container(
                                height: 70.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color:selectedGender=='Male'?
                                  Colors.amber:Colors.black,),
                                  color:selectedGender=='Male'?
                                  Colors.amber.withOpacity(0.1):
                                  Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.male_outlined,size: 50.sp,
                                        color:selectedGender=='Male'?
                                        Colors.amber:Colors.black,),
                                    Text(
                                      'Male',
                                      style: TextStyle(
                                        color:selectedGender=='Male'?
                                        Colors.amber:Colors.black,
                                        fontSize: 18.sp,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          // margin: EdgeInsets.only(top: 15.h),
                          width: 200.w,
                          height: 56.h,
                          padding:
                          EdgeInsets.only(top: 4.h, left: 16.w, bottom: 4.h),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Others',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
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
                                    color: Colors.black,
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
                      ],
                    ),
                  ), 
                  Column(
                    children: [
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Card(
                         color: Colors.white,
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             children: [
                               Center(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text("Enter your name "),
                                     SizedBox(height: 3.h,),
                                     SizedBox(
                                       width: 350.w,
                                       height: 40.h,
                                       child: TextField(
                                         controller: nameController,
                                         decoration: InputDecoration(
                                           hintText: 'Full Name',
                                           hintStyle: TextStyle(
                                             fontSize: 16.sp,
                                             fontFamily: 'Inter',
                                             fontWeight: FontWeight.w400,
                                           ),
                                           border: OutlineInputBorder(
                                             borderSide: BorderSide(
                                               color: nameController.text.isEmpty
                                                   ? Colors.grey
                                                   : Colors.black,
                                               width: 1.w,
                                             ),
                                             borderRadius: BorderRadius.circular(4.r),
                                           ),
                                           enabledBorder: OutlineInputBorder(
                                             borderSide: BorderSide(
                                               color: Colors.grey,
                                               width: 1.w,
                                             ),
                                             borderRadius: BorderRadius.circular(4.r),
                                           ),
                                           focusedBorder: OutlineInputBorder(
                                             borderSide: BorderSide(
                                               color: Colors.black,
                                               width: 1.w,
                                             ),
                                             borderRadius: BorderRadius.circular(4.r),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               GestureDetector(
                                 onTap:()=> _selectDate(context),
                                 child: Container(
                                   margin: EdgeInsets.only(top: 15.h),
                                   width: 313.w,
                                   height: 60.h,
                                   padding: EdgeInsets.only(
                                       top: 4.h, left: 16.w, bottom: 4.h),

                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       isDateSelected?Text("Your Birthday"
                                       , style: TextStyle(
                                           fontSize: 12.sp,
                                           fontFamily: 'Inter',
                                           fontWeight: FontWeight.w500,
                                         ),):SizedBox(),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text(
                                             isDateSelected
                                                 ? userController.formatDate(_formatDate(_dateTime))
                                                 : "When's your birthday",
                                             style: TextStyle(
                                               fontSize: 16.sp,
                                               fontFamily: 'Inter',
                                               fontWeight: FontWeight.w500,
                                             ),
                                           ),
                                           Padding(
                                               padding: EdgeInsets.all(8.0.sp),
                                               child: Icon(
                                                 Icons.calendar_month,
                                                 color: Colors.black,
                                               ))
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 height: 16.h,
                               ),
                               SizedBox(
                                 height: 10.h,
                               ),
                               Container(
                                 width: 313.w,
                                 height: 56.h,
                                 padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                                 decoration: BoxDecoration(
                                   color: Colors.black.withOpacity(0.1),
                                   borderRadius: BorderRadius.circular(12.r),
                                   border: Border.all(color: Colors.black.withOpacity(0.8), width: 1.w),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.black.withOpacity(0.0),
                                       spreadRadius: 2,
                                       blurRadius: 4,
                                       offset: Offset(0, 2), // changes position of shadow
                                     ),
                                   ],
                                 ),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(
                                       'Subject of Interest',
                                       style: TextStyle(
                                         fontSize: 16.sp,
                                         fontFamily: 'Inter',
                                         fontWeight: FontWeight.w600,
                                         color: Colors.black,
                                       ),
                                     ),
                                     DropdownButton<String>(
                                       value: selectedSubject,
                                       onChanged: (String? newValue) {
                                         setState(() {
                                           selectedSubject = newValue;
                                         });
                                       },
                                       icon: Icon(
                                         Icons.arrow_drop_down,
                                         color: Colors.black,
                                       ),
                                       iconSize: 24.sp,
                                       underline: Container(),
                                       items: <String>[
                                         'Mathematics',
                                         'Computer Science'
                                         'Social Science',
                                         'History',
                                         'Accounting and Finance'
                                       ].map<DropdownMenuItem<String>>((String value) {
                                         return DropdownMenuItem<String>(
                                           value: value,
                                           child: Text(
                                             value,
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontWeight: FontWeight.w600,
                                             ),
                                           ),
                                         );
                                       }).toList(),
                                     ),
                                   ],
                                 ),
                               ),

                               SizedBox(
                                 height: 10.h,
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),

SizedBox(height: 10.h,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
                       child: Column(
                         children: [
                           Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(24.0),
                               side: BorderSide(color: agreeToTerms?Colors.greenAccent.withOpacity(0.5): Colors.redAccent.withOpacity(0.5), width: 1.5),
                             ),
                             elevation: 4.0,
                             child: Container(
                               padding: EdgeInsets.all(10.0),
                               child: Row(
                                 children: [
                                   Container(
                                     width: 32.w,
                                     height: 32.h,
                                     decoration: BoxDecoration(
                                       color:agreeToTerms?Colors.greenAccent.withOpacity(0.1):Colors.redAccent.withOpacity(0.1),
                                       borderRadius: BorderRadius.circular(8.0),
                                     ),
                                     child: Checkbox(
                                       activeColor: Colors.green,
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(8.0),
                                       ),
                                       value: agreeToTerms,
                                       onChanged: (newValue) {
                                         setState(() {
                                           agreeToTerms = newValue ?? false;
                                         });
                                       },
                                     ),
                                   ),
                                   SizedBox(width: 16.w),
                                   Text(
                                     'Agree to marketing updates',
                                     style: TextStyle(
                                       color:agreeToTerms?Colors.green: Colors.redAccent,
                                       fontSize: 15.sp,
                                       fontFamily: 'Inter',
                                       fontWeight: FontWeight.w400,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(24.0),
                               side: BorderSide(color:welsh?Colors.greenAccent.withOpacity(0.5): Colors.redAccent.withOpacity(0.5), width: 1.5),
                             ),
                             elevation: 4.0,
                             child: Container(
                               padding: EdgeInsets.all(10.0),
                               child: Row(
                                 children: [
                                   Container(
                                     width: 32.w,
                                     height: 32.h,
                                     decoration: BoxDecoration(
                                       color:welsh? Colors.greenAccent.withOpacity(0.1):Colors.redAccent.withOpacity(0.1),
                                       shape: BoxShape.rectangle,
                                       borderRadius: BorderRadius.circular(8.0),
                                     ),
                                     child: Checkbox(
                                       activeColor: Colors.green,
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(8.0),
                                       ),
                                       value: welsh,
                                       onChanged: (newValue) {
                                         setState(() {
                                           welsh = newValue ?? false;
                                         });
                                       },
                                     ),
                                   ),
                                   SizedBox(width: 16.w),
                                   Text(
                                     'Correspond in Welsh',
                                     style: TextStyle(
                                       color:welsh?Colors.green: Colors.redAccent,
                                       fontSize: 15.sp,
                                       fontFamily: 'Inter',
                                       fontWeight: FontWeight.w400,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ],
                       ),
                     )
                    ],
                  ),
                  SizedBox(height: 15.h,),
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
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
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
