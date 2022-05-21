import 'package:bushier2/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/ChartModel.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';

class ChartWidget extends StatefulWidget {
  @override
  State<ChartWidget> createState() => _ChartWidgetState();

  ChartModel chartModel = ChartModel();

  void calculate() {
    chartModel.calculate();
  }
}

class _ChartWidgetState extends State<ChartWidget> {
  static const String TEXT_AXIS = 'axis';
  static const String TEXT_LABEL = 'label';
  static const String COLOR_COST = 'cost';
  static const String COLOR_ENERGY = 'energy';

  @override
  void initState() {
    super.initState();
    widget.chartModel.defSpf();
    widget.chartModel.addListener(onModelChange);
  }

  void onModelChange() {
    setState(() {});
  }

  TextStyle getChartTextStyle(String textType, String dataType) {
    double size = textType == TEXT_AXIS ? 20 : 14;
    Color color = dataType == COLOR_COST
        ? const Color(0xFF4A87b9)
        : const Color.fromARGB(255, 191, 109, 132);
    return TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size,
        fontWeight: FontWeight.w500);
  }

  Widget resultChart() {
    var a = gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);
    });
    return SfCartesianChart(
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
          title: AxisTitle(
              text: 'Indoor Temperature',
              textStyle: getChartTextStyle(TEXT_AXIS, COLOR_COST)),
          labelStyle: getChartTextStyle(TEXT_LABEL, COLOR_COST)),
      axes: <ChartAxis>[
        NumericAxis(
            name: 'yAxis',
            opposedPosition: true,
            title: AxisTitle(
                text: 'Energy Savings (kJ)',
                textStyle: getChartTextStyle(TEXT_AXIS, COLOR_ENERGY)),
            labelStyle: getChartTextStyle(TEXT_LABEL, COLOR_ENERGY))
      ],
      series: <ChartSeries>[
        // Initialize line series
        SplineAreaSeries<ChartData, String>(
          xAxisName: "Month",
          yAxisName: "Energy Savings (kJ)",
          dataSource: widget.chartModel.energyData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          opacity: 0.5,
        ),

        SplineAreaSeries<ChartData, String>(
          xAxisName: "Month",
          yAxisName: "yAxis",
          dataSource: widget.chartModel.savingsData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y2,
          opacity: 0.5,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CustomWidgets.titleText(context, 'Results'), resultChart()],
    );
  }
}

List<double> vgsFunction() {
  return [
    25.90464123760627,
    25.51539025313001,
    25.142217122232736,
    24.78567094073199,
    24.631320292328564,
    24.64695345207358,
    24.91443700494508,
    25.483382200633088,
    26.423711580820676,
    27.94112584423731,
    29.743614429711318,
    31.57164529634006,
    33.02349568946654,
    33.97686169824807,
    34.516098493136695,
    34.69733782620746,
    34.36601753387889,
    33.192067451460915,
    31.30713170831328,
    29.33195921403876,
    27.698911790877126,
    26.96670960341134,
    26.316700878929417,
    25.729575482462284
  ];
}

List<double> originalFunction() {
  return [
    25.839510268586974,
    25.498065596311886,
    25.175623354147536,
    24.865700096149414,
    24.719366945017022,
    24.76719148221565,
    25.111071341547742,
    25.900038854899996,
    27.27868866358901,
    29.102574960321903,
    31.08735882170869,
    33.00767367811021,
    34.92975783189658,
    37.086163374976124,
    39.135540050182094,
    40.31708850026672,
    40.044588302699424,
    38.16147355561849,
    34.955671827563265,
    31.483465346697656,
    28.783702262804017,
    27.40978357466948,
    26.15917611709338,
    25.05641167064305
  ];
}
