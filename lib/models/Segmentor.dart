import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/widgets.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Segmentor {
  static const ASSET_NAME = "assets/latest.tflite";
  static const MODEL_NAME = "bushier";
  static const NUM_THREADS = 4;
  static List<int> LABELME_FACADE_PALATTE = [
    const Color.fromARGB(255, 0, 0, 0).value,
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
  late InterpreterOptions _interpreterOptions;

  late List<int> _inputShape;
  late List<int> _outputShape;
  late TensorImage _inputImage;
  late TensorBuffer _outputBuffer;

  NormalizeOp preProcessNormalizeOp = NormalizeOp(114.5, 57.63);

  late List<String> labels;

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
      _interpreterOptions = InterpreterOptions();
      _interpreterOptions.threads = NUM_THREADS;
      loadModel(localModelFile);
    });
  }

  Future<void> loadModel(File localModelFile) async {
    try {
      interpreter = await Interpreter.fromFile(localModelFile, options: _interpreterOptions);
      print('Interpreter Created Successfully');

      _inputShape = interpreter.getInputTensor(0).shape;
      _outputShape = interpreter.getOutputTensor(0).shape;
      _outputBuffer = TensorBuffer.createFixedSize(_outputShape, TfLiteType.uint8);

      print('Input shapes ${_inputShape}, output shapes ${_outputShape}');
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  TensorImage _preProcess() {
    // int cropSize = min(_inputImage.height, _inputImage.width);
    return ImageProcessorBuilder()
        // .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(_inputShape[2], _inputShape[3], ResizeMethod.NEAREST_NEIGHBOUR))
        .add(preProcessNormalizeOp)
        .build()
        .process(_inputImage);
  }

  Uint8List segment(String imagePath) {
    final pres = DateTime.now().millisecondsSinceEpoch;
    File imageFile = File(imagePath);
    _inputImage = TensorImage.fromFile(imageFile);
    _inputImage = _preProcess();
    final pre = DateTime.now().millisecondsSinceEpoch - pres;

    print('Segmentor/segment: Time to load image: $pre ms');
    print('Segmentor/segment: ${_inputImage.buffer.asFloat32List()}');

    final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(_inputImage.buffer, _outputBuffer.getBuffer());
    final run = DateTime.now().millisecondsSinceEpoch - runs;

    print('Segmentor/segment: Time to run inference: $run ms');

    Uint8List labelList = _outputBuffer.buffer.asUint8List();
    return labelList;
  }

  Uint8List visualise(Uint8List labelList) {
    print('Segmentor/visualise: $labelList');
    List<int> visList = labelList.map((e) => LABELME_FACADE_PALATTE[e]).toList();
    print('Segmentor/visualise: $visList');
    Uint8List visImage = Uint32List.fromList(visList).buffer.asUint8List();
    print('Segmentor/visualise: $visImage');
    return visImage;
  }

  void destroy() {
    interpreter.close();
  }
}