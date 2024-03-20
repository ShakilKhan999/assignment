import 'dart:convert';

import 'package:assignment/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../userModel.dart';

class UserRepository{

  UserController userController=Get.put(UserController());

  Future<String> createUserDta(
      {required String email, required String password,required double? lat,required double? long}) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            'https://tiny-jade-chicken-hose.cyclic.app/api/v1/user/update-user-by-id/65f863b047431738286235eb'));
    request.body = json.encode({
      "SubjectCategory": [],
      "email": email.trim(),
      "password": password,
      "fullName": '',
      "AppKey": "app1",
      "dateOfBirth": '',
      "Gender": '',
      "agreeToMarketing": false,
      "latitude": lat,
      "longitude": long,
      "createdAt": DateTime.now().toString(),
      "updatedAt": DateTime.now().toString(),
      "__v": 0
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      var userId = jsonResponse['data']['_id'];
      return userId; // Return user ID
    } else {
      return 'failed'; // Return 'failed'
    }
  }


  Future<UserModel> fetchUserData(String userId) async {
    final url = Uri.parse('https://tiny-jade-chicken-hose.cyclic.app/api/v1/user/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final Map<String, dynamic> userData = json.decode(response.body);
      print("User:\n${userData.toString()}");
      return UserModel.fromJson(userData);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load user data');
    }
  }


  Future<bool> loginUser(String email, String password) async {
    EasyLoading.show();
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'GET', Uri.parse('https://tiny-jade-chicken-hose.cyclic.app/api/v1/user/log-in'));
    request.body = json.encode({
      "email": email.trim(),
      "password": password,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response;
    try {
      response = await request.send();
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        var userId = jsonResponse['data'][0]['_id'];
         userController.userId.value=userId;
        // Login successful
        return true;
      } else {
        EasyLoading.dismiss();
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        String errorMessage = jsonResponse['message'] ?? 'Login failed';
        // Login failed
        print("sfsfsdfd"+response.reasonPhrase.toString());
        return false;
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error: $e');
      return false;
    }
  }

  Future<bool> updateUserById({
    required double? lat,required double? long,
    required String userId,
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required bool agreeToMarketing,
    required bool correspond,
    required String updatedAt,
  }) async {
    //EasyLoading.show();
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request(
      'PATCH',
      Uri.parse('https://tiny-jade-chicken-hose.cyclic.app/api/v1/user/update-user-by-id/$userId'),
    );
    request.body = json.encode({
      "fullName": fullName,
      "dateOfBirth": dateOfBirth,
      "Gender": gender,
      "agreeToMarketing": agreeToMarketing,
      "correspond": correspond,
      "latitude": lat,
      "longitude": long,
      "updatedAt": updatedAt,
      "__v": 0
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     // EasyLoading.dismiss();
      return true; // Update successful
    } else {
      var error= await response.stream.bytesToString();
      print("Error Updating: ${error.toString()}");
      //EasyLoading.dismiss();
      return false; // Update failed
    }
  }


  Future<String> getPlaceName(double latitude, double longitude) async {
    latitude=0.0;longitude=0.0;
    final apiKey = 'AIzaSyAXE8HlQ-q9loKBtRHm6ykDOixQDGlNgFA'; // Replace with your API key
    final apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    try {
      // Make an HTTP GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if the status in the response is OK
        if (data['status'] == 'OK') {
          // Extract the formatted address (place name) from the results
          final results = data['results'] as List<dynamic>;
          if (results.isNotEmpty) {
            print("address:  "+results[0]['formatted_address']);
            return results[0]['formatted_address'];
          }
        }
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print('Error fetching place name: $e');
    }

    // Return null if unable to fetch the place name
    return '';
  }
}