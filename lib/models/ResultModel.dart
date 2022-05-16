import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'SensorDataRetriever.dart';

class ResultsModel {
  ResultsModel(
    this.avgTemp,
    this.orientationMultipler,
    this.baseTemp,
    this.airHeatCapacity,
    this.airDensity,
    this.roomVol,
    this.btuConversion,
    this.energyEfficientRatio
  ) {
    getBTU();
    getWattHour();
    getDayEnergy();
    getMonthEnergy();
  }

  double avgTemp;
  double orientationMultipler;
  double baseTemp;
  double airHeatCapacity;
  double airDensity;
  double roomVol;
  double btuConversion;
  double energyEfficientRatio;

  late double BTU;
  late double wattHour;
  late double dayEnergy;
  late double monthEnergy;

  double? getBTU() {
    BTU = 2 * airDensity * roomVol * airHeatCapacity * btuConversion;
  }
  double? getWattHour() {
    wattHour = BTU / energyEfficientRatio;
  }
  double? getDayEnergy() {
    dayEnergy = wattHour * 24;
  }
  double? getMonthEnergy() {
    monthEnergy = dayEnergy * 30;
  }
}


Future<double> convertArea(List<double> target,
    {double length = 80, double height = 90, int climate = 1}) async {
  // target: building gpa posi
  // length: base width of building in m
  // height: height of building in m
  // climate: 1 = singapore

  SensorDataRetriever? SDR;

  Position position = await SDR!.getPosition();

  double angle = Geolocator.bearingBetween(
      position.latitude, position.longitude, target[0], target[1]);

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

  double BTU = 2 *
      airDensity *
      roomVol *
      airHeatCapacity *
      btuConversion; // Q = (Change in temp) * (Mass) * (Heat capacity)
  double wattHour = BTU / energyEfficentRatio;
  double dayEnergy = wattHour * 24;
  double monthEnergy = dayEnergy * 30;

  return monthEnergy;
}
