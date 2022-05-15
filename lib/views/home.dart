import 'dart:io';
import 'dart:math';

import 'package:bushier2/views/capture.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vector_math/vector_math.dart';

import '../models/DAO.dart';

class HomeView extends StatefulWidget {
  final CameraDescription cameraDescription;
  final String? imagePath;

  const HomeView({
    Key? key,
    this.imagePath,
    required this.title,
    required this.cameraDescription,
  }) : super(key: key);

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DAO dao = DAO();

  Widget takePictureButton() {
    return FloatingActionButton(
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
      child: const Icon(Icons.camera),
    );
  }
  
  Widget dbTestButton() {
    return FloatingActionButton(
      onPressed: () async {
        dao.update();
      },
      child: const Icon(Icons.add),
    );
  }

  Widget resultChart() {
    return SfCartesianChart(
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
          title: AxisTitle(
              text: 'Energy Savings',
              textStyle: TextStyle(
                  color: Color(0xFF4A87b9),
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          labelStyle: TextStyle(
              color: Color(0xFF4A87b9),
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      axes: <ChartAxis>[
        NumericAxis(
            name: 'yAxis',
            opposedPosition: true,
            title: AxisTitle(
                text: 'Cost Savings',
                textStyle: TextStyle(
                    color: Color.fromARGB(255, 191, 109, 132),
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            labelStyle: TextStyle(
                color: Color.fromARGB(255, 191, 109, 132),
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w500))
      ],
      series: <ChartSeries>[
        // Initialize line series
        SplineAreaSeries<ChartData, String>(
            xAxisName: "Month",
            yAxisName: "Energy Savings",
            dataSource: energyData(),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y),
        SplineAreaSeries<ChartData, String>(
            xAxisName: "Month",
            yAxisName: "yAxis",
            dataSource: savingsData(),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center( // layout widget, positions single child in middle of parent
        child: Column( // layout widget, arrange children vertically
          mainAxisAlignment: MainAxisAlignment.center, // center children vertically
          children: <Widget>[
            (widget.imagePath == null)
              ? const Text("Press on '+' and take a picture!")
              : Image.file(File(widget.imagePath!)),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
            ),
            Text(
              'Results',
              style: new TextStyle(fontSize: 25.0),
            ),
            resultChart()
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            takePictureButton(),
            const SizedBox(height: 10),
            dbTestButton()
          ],
        ),
      )
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y2);
  final String x;
  final double? y;
  final double? y2;
}

List<ChartData> energyData() {
  return [
    // Bind data source
    ChartData('Jan', 35, 1000),
    ChartData('Feb', 28, 2000),
    ChartData('Mar', 34, 3500),
    ChartData('Apr', 32, 5500),
    ChartData('May', 40, 6200)
  ];
}

List<ChartData> savingsData() {
  return [
    // Bind data source
    ChartData('Jan', 35, 1000),
    ChartData('Feb', 28, 2000),
    ChartData('Mar', 34, 3500),
    ChartData('Apr', 32, 5500),
    ChartData('May', 40, 6200)
  ];
}

List<double> convertArea(
    List<double> position, List<double> target, double length, double height,
    {int climate = 1}) {
  // position: cur gps posi
  // target: building gpa posi
  // length: base width of building
  // height: height of building
  // climate: 1 = singapore

  double angle =
  degrees(atan2(position[0] - target[0], position[1] - target[1]));

  if (climate == 1) {
    // Tropical Climate
    double avgTemp =
    27; // Correlating indoor and outdoor temperature and humidity in a sample of buildings in tropical climates
    double orientationMultiplier =
    1.01; // Effect Of Orientation On Indoor Temperature Case Study: Yekape Penjaringansari Housing in Surabaya
    double baseTemp = avgTemp + (cos(angle)).abs() * orientationMultiplier;
  } else {
    // Desert/Arid Climate
    double orientationTemperature =
    1; // Influence of building orientation on internal temperature in saharan climates, building located in Ghardaïa region
    // Assume little to no top incident solar radiation
    double avgTemp =
    33; // The Effect of Thermal Insulation on Cooling Load in Residential Buildings in Makkah, Saudi Arabia
    // Impact of glazing to wall ratio in various climatic regions: A case study
    double changeTemp =
    3; // Thermal improvement by means of leaf cover on external walls — A simulation model
  }

  //Energy Calculations
  double airHeatCapacity = 1012; // j/(kg K)
  double airDensity = 1.225; // kg/m^3
  double roomVol = pow(length, 2) * height;
  double btuConversion = 1 / 1055;
  double energyEfficentRatio = 10; // BTU removed per hour/watt drawn

  return [1.0, 2.0];
}