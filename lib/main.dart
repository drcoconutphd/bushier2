import 'package:bushier2/views/SplashView.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  WidgetsFlutterBinding.ensureInitialized();
  final cameraDescList = await availableCameras();
  final firstCamera = cameraDescList.first;

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: 'Bushier2 Demo',
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: SplashView(cameraDescription: firstCamera),
  ));
}
