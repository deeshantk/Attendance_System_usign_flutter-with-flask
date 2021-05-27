import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:attendence_app/views/dashboardScreen.dart';

class HttpService {
  static final _client = http.Client();

  static var _loginUrl = Uri.parse('http://192.168.43.189:5000/login');

  static var _registerUrl = Uri.parse('http://192.168.43.189:5000/register');

  static login(username, pass, context) async {
    http.Response response = await _client.post(_loginUrl, body: {
      'uname': username,
      'passw': pass,
    });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);
      if(json['status'] == "All data has been shown")
        await EasyLoading.showSuccess(json['status']);
      else if (json['status'] == "0") {
        await EasyLoading.showSuccess("Sucessfully logged-in");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen(username: json['status'])));
      } else {
        EasyLoading.showError("Incorrect username or password");
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  static register(username, email, pass, context) async {
    http.Response response = await _client.post(_registerUrl, body: {
      'uname': username,
      'mail': email,
      'passw': pass,
      'atten':'0'
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['status'] == "22") {
        await EasyLoading.showError("User already taken");
      } else {
        await EasyLoading.showSuccess("Succesfully Registered");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
    } else {
      await EasyLoading.showError(
          "Error Code here: ${response.statusCode.toString()}");
    }
  }
}