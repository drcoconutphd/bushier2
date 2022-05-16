import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CaptureView extends StatefulWidget {
  const CaptureView({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  CaptureViewState createState() => CaptureViewState();
}

class CaptureViewState extends State<CaptureView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: FutureBuilder<void>( // waits till controller initialised
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.done && false)
            ? CameraPreview(_controller)
            : Center(
              child: Image.asset('assets/images/Picture2.png')
            );
            // : const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture; // ensure camera is initialized.
            final image = await _controller.takePicture(); // xfile
            Navigator.pop(context, image.path); //return result to home page
          } catch (e) {
            SnackBar(content: Text(e.toString()));
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}