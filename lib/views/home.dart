import 'package:bushier2/views/capture.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final CameraDescription cameraDescription;

  const HomeView({
    Key? key,
    required this.title,
    required this.cameraDescription,
  }) : super(key: key);

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called

    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center( // layout widget, positions single child in middle of parent
        child: Column( // layout widget, arrange children vertically
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.

          mainAxisAlignment: MainAxisAlignment.center, // center children vertically
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CaptureView(
                  camera: widget.cameraDescription
                ),
              ),
            );
          } catch (e) {
            SnackBar(content: Text(e.toString()));
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}