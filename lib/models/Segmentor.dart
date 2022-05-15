import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/widgets.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

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
  late Interpreter interpreter;

  Segmentor() {
    FirebaseModelDownloader instance = FirebaseModelDownloader.instance;

    FirebaseModelDownloadConditions conditions = FirebaseModelDownloadConditions(
      iosAllowsCellularAccess: true,
      iosAllowsBackgroundDownloading: false,
      androidChargingRequired: false,
      androidWifiRequired: false,
      androidDeviceIdleRequired: false,
    );

    instance.getModel(
        MODEL_NAME, FirebaseModelDownloadType.localModel, conditions
    ).then((customModel) async {
      // The CustomModel object contains the local path of the model file,
      // which you can use to instantiate a TensorFlow Lite interpreter.
      final localModelFile = customModel.file;
      interpreter = await Interpreter.fromFile(localModelFile);
      print("Model loaded!!!");
    });

    ImageProcessor imageProcessor = ImageProcessorBuilder()
        .add(ResizeOp(224, 224, ResizeMethod.NEAREST_NEIGHBOUR))
        .build();
  }

  void segment() {

  }

  void destroy() {
    interpreter.close();
  }

}