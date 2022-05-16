import 'package:bushier2/models/NasaDataRetriever.dart';
import 'package:bushier2/models/SensorDataRetriever.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'ResultModel.dart';

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
        params: [NasaData.t2m, NasaData.t2m_max]);

    convertArea([1.3539504607263098, 103.68779725423865]);

    List<double> t2m = nasaData.temps[NasaData.t2m]!;
    energyData = [];
    for (int i = 0; i < MONTH.length; i++) {
      energyData.add(ChartData(MONTH[i], t2m[i], t2m[i]));
    }

    notifyListeners();
  }

  void defSpf() {
    energyData = [
      ChartData('May', 27.69, 1848),
      ChartData('Jun', 26.7, 2640),
      ChartData('Jul', 25.24, 3808),
      ChartData('Aug', 25.09, 3928),
      ChartData('Sep', 25.8, 3360),
      ChartData('Oct', 26.39, 2888),
      ChartData('Nov', 27.05, 2360),
      ChartData('Dec', 26.81, 2552),
    ];
    savingsData = [
      ChartData('May', 27.69, 1848),
      ChartData('Jun', 26.7, 2640),
      ChartData('Jul', 25.24, 3808),
      ChartData('Aug', 25.09, 3928),
      ChartData('Sep', 25.8, 3360),
      ChartData('Oct', 26.39, 2888),
      ChartData('Nov', 27.05, 2360),
      ChartData('Dec', 26.81, 2552),
    ];
  }
}
