import 'dart:typed_data';

import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/widgets.dart';
// import 'package:tflite/tflite.dart';

class Segmentor {
  static const MODEL_NAME = "bushier";
  static List<int> LABELME_FACADE_PALATTE = [
    const Color.fromARGB(255, 128, 0, 0).value,
    const Color.fromARGB(255, 128, 0, 128).value,
    const Color.fromARGB(255, 128, 128, 0).value,
    const Color.fromARGB(255, 128, 128, 128).value,
    const Color.fromARGB(255, 128, 64, 0).value,
    const Color.fromARGB(255, 0, 128, 128).value,
    const Color.fromARGB(255, 0, 128, 0).value,
    const Color.fromARGB(255, 0, 0, 128).value,
  ];

  // Segmentor() {
  //   FirebaseModelDownloader instance = FirebaseModelDownloader.instance;

  //   FirebaseModelDownloadConditions conditions = FirebaseModelDownloadConditions(
  //     iosAllowsCellularAccess: true,
  //     iosAllowsBackgroundDownloading: false,
  //     androidChargingRequired: false,
  //     androidWifiRequired: false,
  //     androidDeviceIdleRequired: false,
  //   );

  //   instance.getModel(
  //       MODEL_NAME, FirebaseModelDownloadType.localModel, conditions
  //   ).then((customModel) async {
  //     // The CustomModel object contains the local path of the model file,
  //     // which you can use to instantiate a TensorFlow Lite interpreter.
  //     final localModelPath = customModel.file;

  //     String? res = await Tflite.loadModel(
  //         model: localModelPath.path,
  //         labels: "assets/labels.txt",
  //         numThreads: 1, // defaults to 1
  //         isAsset: true, // defaults to true, set to false to load resources outside assets
  //         useGpuDelegate: false // defaults to false, set to true to use GPU delegate
  //     );
  //   });
  // }

  // Future<Uint8List?> segment(String path) async {
  //   // mean=[123.675, 116.28, 103.53], std=[58.395, 57.12, 57.375]
  //   Uint8List? segOutput = await Tflite.runSegmentationOnImage(
  //       path: path,
  //       imageMean: 117.0,
  //       imageStd: 57.5,
  //       labelColors: LABELME_FACADE_PALATTE,
  //       asynch: true
  //   );
  //   return segOutput;
  // }
}