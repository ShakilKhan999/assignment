import 'package:assignment/repo/userRepository.dart';
import 'package:assignment/screens/question_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    _requestLocationPermission();
    getCurrentLocation();
    super.onInit();
  }

  var UserData = [].obs;
  var registrationDone = false.obs;
  var fetchReport = ''.obs;
  var loading = false.obs;
  var userId = ''.obs;
  var address = ''.obs;
  var lat = 0.0.obs;
  var long = 0.0.obs;

  Future<void> _requestLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      // Permission is already granted
      print('Location permission is granted.');
    } else {
      // Permission has not been granted yet
      PermissionStatus status = await Permission.location.request();
      if (status.isDenied) {
        // Permission has been denied
        print('Location permission is denied.');
      } else if (status.isPermanentlyDenied) {
        // Permission has been permanently denied
        print('Location permission is permanently denied.');
        // You can open the app settings to let the user manually enable the permission
        openAppSettings();
      }
    }
  }

  Future<bool> createUser(
      {required String email, required String password}) async {
    String ff = await UserRepository().createUserDta(
        lat: lat.value, long: long.value, email: email, password: password);
    if (ff != 'failed') {
      userId.value = ff;
      registrationDone.value = true;
      await fetchUserData(ff);
      return true;
    } else {
      return false;
    }
  }

  Future<void> fetchUserData(String userId) async {
    fetchReport.value = '';
    UserData.clear();
    UserData.add(await UserRepository().fetchUserData(userId));
  }

  Future<bool> login(String email, String password) async {
    return UserRepository().loginUser(email, password);
  }

  Future<bool> updateUser({
    required String userId,
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required bool agreeToMarketing,
    required bool correspond,
    required String updatedAt,
    required List<String> sub,
  }) async {
    return UserRepository().updateUserById(
        lat: lat.value,
        long: long.value,
        userId: userId,
        fullName: fullName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        agreeToMarketing: agreeToMarketing,
        correspond: correspond,
        updatedAt: updatedAt,
        subjects: sub);
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> getCurrentLocation() async {
    try {
      // Request permission to access the device's location
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Handle permission denied
        return null;
      }

      // Get the current position (latitude and longitude)
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat.value = position.latitude;
      long.value = position.longitude;

      print("Location: ${lat.value}  ${long.value}");
    } catch (e) {
      // Handle any errors that occur
      print('Error getting current location: $e');
      return null;
    }
  }
  String formatDate(String inputDate) {
    // Parse the inputDate string to DateTime
    DateTime dateTime = DateFormat("dd/MM/yyyy").parse(inputDate);

    // Format the DateTime to desired format
    String formattedDate = DateFormat("d MMMM y").format(dateTime);

    // Convert the first letter of month to uppercase
    formattedDate = formattedDate.replaceRange(0, 1, formattedDate[0].toUpperCase());



    return formattedDate;
  }

}
