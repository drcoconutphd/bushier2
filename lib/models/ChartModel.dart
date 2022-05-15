import 'package:bushier2/NasaDataDispatcher.dart';

class ChartData {
  ChartData(this.x, this.y, this.y2);
  final String x;
  final double? y;
  final double? y2;
}

class ChartModel {
  List<ChartData> energyData = [];
  List<ChartData> savingsData = [];
  NasaDataRetriever nasaDataRetriever = NasaDataRetriever();

  void calculate() {
    final nasaData = nasaDataRetriever.getData(
        lat: 0.0,
        lng: 0.0,
        params: [NasaData.t2m, NasaData.t2m_max]
    );
  }

  void spoof() {
    energyData = [
      ChartData('Jan', 35, 1000),
      ChartData('Feb', 28, 2000),
      ChartData('Mar', 34, 3500),
      ChartData('Apr', 32, 5500),
      ChartData('May', 40, 6200)
    ];
    savingsData = [
      ChartData('Jan', 35, 1000),
      ChartData('Feb', 28, 2000),
      ChartData('Mar', 34, 3500),
      ChartData('Apr', 32, 5500),
      ChartData('May', 40, 6200)
    ];
  }
}