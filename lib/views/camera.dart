import 'dart:async';
import 'dart:io';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
//import 'package:image_picker/image_picker.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(CameraApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: CameraApp(),
        floatingActionButton: null,
      )
    );
  }
  //_CameraAppState createState() => _CameraAppState();
}

class CameraApp extends StatefulWidget{
  @override
  CameraAppState createState() => CameraAppState(); 
}

class CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return CameraPreview(controller);
  }
}