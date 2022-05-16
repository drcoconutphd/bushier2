import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../models/DAO.dart';
import '../models/Segmentor.dart';
import 'CaptureView.dart';
import 'ChartWidget.dart';
import 'VendorPage.dart';

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
  DAO dao = DAO();
  ChartWidget chartWidget = ChartWidget();
  Segmentor segmentor = Segmentor();
  String? imagePath;
  Uint8List? visList;

  Widget takePictureButton() {
    return FloatingActionButton(
      onPressed: () async {
        try {
          imagePath = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  CaptureView(camera: widget.cameraDescription),
            ),
          );
          setState(() {});
        } catch (e) {
          SnackBar(content: Text(e.toString()));
        }
      },
      child: const Icon(Icons.camera),
    );
  }

  Widget searchVendorsButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VendorPage(),
          ),
        );
      },
      child: const Icon(Icons.add_shopping_cart_outlined),
    );
  }

  void calculate() {
    if (imagePath != null) {
      Uint8List labelList = segmentor.segment(imagePath!);
      visList = segmentor.visualise(labelList);
      setState(() {});
      print("HomeView/calculateTestButton: aft seg\n$visList");
    }
  }

  Widget calculateTestButton() {
    return FloatingActionButton(
      onPressed: () async {
        chartWidget.calculate();
        if (imagePath != null) {
          Uint8List labelList = segmentor.segment(imagePath!);
          visList = segmentor.visualise(labelList);
          setState(() {});
          print("HomeView/calculateTestButton: aft seg\n$visList");
        }
      },
      child: const Icon(Icons.calculate),
    );
  }

  @override
  Widget build(BuildContext context) {
    const area = 110;
    const change = 1.00;
    const energy = 1848;
    const savings = 460;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              // layout widget, positions single child in middle of parent
              child: (imagePath == null)
                  ? const Text("Press on '+' and take a picture!")
                  : Column(
                      // layout widget, arrange children vertically
                      mainAxisAlignment: MainAxisAlignment
                          .center, // center children vertically
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        ),
                        const Text("Captured image"),
                        const SizedBox(height: 10),
                        Image.asset('assets/images/Picture2.png'),
                        const SizedBox(height: 10),
                        const Text("Processed image overlay"),
                        const SizedBox(height: 10),
                        (visList == null)
                            ? const Text("Press on calculate to see results!")
                            : Column(
                                children: [
                                  Image.asset('assets/images/Picture1.png'),
                                  // : Image.memory(Bitmap.fromHeadless(384, 512, visList!).buildHeaded()),
                                  const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(50, 10, 50, 10),
                                  ),
                                  chartWidget,
                                  const Text("Area of Wall: $area sqft"),
                                  const SizedBox(height: 10),
                                  const Text(
                                      "Change in temprature: $change deg"),
                                  const SizedBox(height: 10),
                                  const Text(
                                      "Energy Savings for 1st Month: $energy kJ"),
                                  const SizedBox(height: 10),
                                  const Text("Cost savings: $savings /kWh"),
                                  const SizedBox(height: 10),
                                ],
                              )
                      ],
                    ),
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                takePictureButton(),
                const SizedBox(height: 10),
                calculateTestButton(),
                const SizedBox(height: 10),
                searchVendorsButton(),
              ],
            ),
          ),
        ));
  }
}
