import 'dart:io';

import 'package:bushier2/views/CaptureView.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/ChartModel.dart';
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
  ChartModel chartModel = ChartModel();

  @override
  void initState() {
    super.initState();
    chartModel.spoof();
  }

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

  static const String TEXT_AXIS = 'axis';
  static const String TEXT_LABEL = 'label';
  static const String COLOR_COST = 'cost';
  static const String COLOR_ENERGY = 'energy';


  TextStyle getChartTextStyle(String textType, String dataType) {
    double size = textType == TEXT_AXIS ? 20 : 14;
    Color color = dataType == COLOR_COST ? const Color(0xFF4A87b9)
        : const Color.fromARGB(255, 191, 109, 132);
    return TextStyle(
      color: color,
      fontFamily: 'Roboto',
      fontSize: size,
      fontWeight: FontWeight.w500
    );
  }

  Widget resultChart() {
    return SfCartesianChart(
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
          title: AxisTitle(
              text: 'Energy Savings',
              textStyle: getChartTextStyle(TEXT_AXIS, COLOR_COST)),
          labelStyle: getChartTextStyle(TEXT_LABEL, COLOR_COST)),
      axes: <ChartAxis>[
        NumericAxis(
            name: 'yAxis',
            opposedPosition: true,
            title: AxisTitle(
                text: 'Cost Savings',
                textStyle: getChartTextStyle(TEXT_AXIS, COLOR_ENERGY)),
            labelStyle: getChartTextStyle(TEXT_LABEL, COLOR_ENERGY))
      ],
      series: <ChartSeries>[
        // Initialize line series
        SplineAreaSeries<ChartData, String>(
            xAxisName: "Month",
            yAxisName: "Energy Savings",
            dataSource: chartModel.energyData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y),
        SplineAreaSeries<ChartData, String>(
            xAxisName: "Month",
            yAxisName: "yAxis",
            dataSource: chartModel.savingsData,
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
