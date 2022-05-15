import 'package:bushier2/models/NasaDataRetriever.dart';
import 'package:bushier2/models/SensorDataRetriever.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class ChartData {
  ChartData(this.x, this.y, this.y2);
  final String x;
  double? y;
  double? y2;
}

class ChartModel extends ChangeNotifier {
  static const List MONTH = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<ChartData> energyData = [];
  List<ChartData> savingsData = [];
  HttpDataRetriever httpDataRetriever = HttpDataRetriever();
  SensorDataRetriever sensorDataRetriever = SensorDataRetriever();

  Future<void> calculate() async {
    Position pos = await sensorDataRetriever.getPosition();
    NasaPayload nasaData = await httpDataRetriever.getNasaData(
        lat: pos.latitude,
        lng: pos.longitude,
        params: [NasaData.t2m, NasaData.t2m_max]
    );

    List<double> t2m = nasaData.temps[NasaData.t2m]!;
    energyData = [];
    for (int i = 0; i < MONTH.length; i++) {
      energyData.add(ChartData(MONTH[i], t2m[i], t2m[i]));
    }

    notifyListeners();
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