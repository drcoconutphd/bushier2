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
      this.energyEfficientRatio) {
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

  SensorDataRetriever SDR = SensorDataRetriever();

  Position position = await SDR.getPosition();

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
