import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/ChartModel.dart';

class ChartWidget extends StatefulWidget {
  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  static const String TEXT_AXIS = 'axis';
  static const String TEXT_LABEL = 'label';
  static const String COLOR_COST = 'cost';
  static const String COLOR_ENERGY = 'energy';

  ChartModel chartModel = ChartModel();

  @override
  void initState() {
    super.initState();
    chartModel.spoof();
  }

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
    return Column(
      children: [
        const Text(
          'Results',
          style: TextStyle(fontSize: 25.0),
        ),
        resultChart()
      ],
    );
  }
}