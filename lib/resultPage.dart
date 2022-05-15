import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          child: Column(
        children: [
          new Padding(
            padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
          ),
          new Text(
            'Results',
            style: new TextStyle(fontSize: 25.0),
          ),
          SfCartesianChart(
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
          ),
        ],
      )),
    ));
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating
    return Scaffold();
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
