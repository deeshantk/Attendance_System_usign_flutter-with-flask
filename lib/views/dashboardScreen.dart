import 'package:attendence_app/views/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DashboardScreen extends StatelessWidget {
  String username;
  List<CameraDescription> cameras;
  DashboardScreen({this.username});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if(username == "0"){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp()));
              }
              else if(username == 'admin'){
                
              }
              else{
                EasyLoading.showError("Attendence already marked");
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                  child: Text(
                'Open Camera',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
          ),
        ]
      )
    );
  }
}