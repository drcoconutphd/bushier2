import 'package:bushier2/views/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  WidgetsFlutterBinding.ensureInitialized();
  final cameraDescList = await availableCameras();
  final firstCamera = cameraDescList.first;

  runApp(
    MaterialApp(
      title: 'Bushier2 Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Bushier2',
        cameraDescription: firstCamera,
      ),
    )
  );
}
