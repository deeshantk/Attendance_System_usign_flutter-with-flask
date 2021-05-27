import 'package:flutter/material.dart';
import 'package:attendence_app/service/http_Service.dart';
import 'package:attendence_app/views/camera.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username;

  String pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'username'),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  pass = value;
                });
              },
            ),
            InkWell(
              onTap: () async {
                await HttpService.login(username, pass, context).toString();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                    child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}