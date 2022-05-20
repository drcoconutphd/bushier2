import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/DAO.dart';
import '../models/Segmentor.dart';
import 'CaptureView.dart';
import 'ChartWidget.dart';
import 'VendorPage.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

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
    List<double> ls = convertArea([1.353934978563778, 103.68775499966486],
        [1.353934978563778, 103.68775499966486]);
    double area = ls[0];
    double change = ls[1];
    double energy = ls[2];
    double savings = ls[3];
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              // layout widget, positions single child in middle of parent
              child: (imagePath == null)
                  ? Text("Press on camera and take a picture!",
                    style: CustomWidgets.instructionTextStyle(context))
                  : Column(
                      // layout widget, arrange children vertically
                      mainAxisAlignment: MainAxisAlignment
                          .center, // center children vertically
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        ),
                        CustomWidgets.titleText(context, 'Captured Image'),
                        const SizedBox(height: 10),
                        Image.asset('assets/images/Picture2.png'),
                        const SizedBox(height: 10),
                        (visList == null)
                            ? Text("Press on calculate to see results!",
                              style: CustomWidgets.instructionTextStyle(context))
                            : Column(
                                children: [
                                  CustomWidgets.titleText(context,
                                      'Processed Image Overlay'),
                                  const SizedBox(height: 10),
                                  Image.asset('assets/images/Picture1.png'),
                                  // : Image.memory(Bitmap.fromHeadless(384, 512, visList!).buildHeaded()),
                                  const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(50, 10, 50, 10),
                                  ),
                                  chartWidget,
                                  Text("Area of Wall: $area sqft"),
                                  const SizedBox(height: 10),
                                  Text("Change in temprature: $change deg"),
                                  const SizedBox(height: 10),
                                  Text(
                                      "Energy Savings for 1st Month: $energy kJ"),
                                  const SizedBox(height: 10),
                                  Text("Cost savings: $savings /kWh"),
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

List<double> convertArea(List<double>? target, List<double>? position,
    {double length = 10, double height = 11, int climate = 1}) {
  // target: building gpa posi
  // length: base width of building in m
  // height: height of building in m
  // climate: 1 = singapore

  target ??= [1.3539504607263098, 103.68779725423865];
  position ??= [1.353934978563778, 103.68775499966486];

  double angle =
      Geolocator.bearingBetween(position[0], position[1], target[0], target[1]);
  double change = 1.00; // default val
  double savings = 460;

  if (climate == 1) {
    // Tropical Climate
    double avgTemp =
        27; // Correlating indoor and outdoor temperature and humidity in a sample of buildings in tropical climates
    double orientationMultiplier =
        1.01; // Effect Of Orientation On Indoor Temperature Case Study: Yekape Penjaringansari Housing in Surabaya
    double baseTemp = avgTemp + (cos(angle)).abs() * orientationMultiplier;
    double change = 1.0;
  } else {
    // Desert/Arid Climate
    double orientationTemperature =
        1; // Influence of building orientation on internal temperature in saharan climates, building located in Ghardaïa region
    // Assume little to no top incident solar radiation
    double avgTemp =
        33; // The Effect of Thermal Insulation on Cooling Load in Residential Buildings in Makkah, Saudi Arabia
    // Impact of glazing to wall ratio in various climatic regions: A case study
    double baseTemp = avgTemp + (cos(angle)).abs() * orientationTemperature;
    double change =
        3; // Thermal improvement by means of leaf cover on external walls — A simulation model
  }

  //Energy Calculations
  double airHeatCapacity = 1012; // j/(kg K)
  double airDensity = 1.225; // kg/m^3
  double roomVol = pow(length, 2) * height;
  double btuConversion = 1 / 1055;
  double energyEfficentRatio = 10; // BTU removed per hour/watt drawn

  double BTU = 2 *
      airDensity *
      roomVol *
      airHeatCapacity *
      btuConversion; // Q = (Change in temp) * (Mass) * (Heat capacity)
  double wattHour = BTU / energyEfficentRatio;
  double dayEnergy = wattHour * 24;
  double monthEnergy = dayEnergy * 30;

  return [length * height, change, monthEnergy, savings];
}
