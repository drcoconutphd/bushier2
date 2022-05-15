import 'dart:convert';

import 'package:http/http.dart' as http;

class NasaData {
  static const String t2m = "T2M";
  static const String t2m_max = "T2M_MAX";
  // See https://power.larc.nasa.gov/docs/services/api/ or
  // https://power.larc.nasa.gov/#resources for other parameters
}

class NasaPayload {
  final Map<String, List<double>> temps;
  NasaPayload({required this.temps});

  factory NasaPayload.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> params = json['properties']['parameter'];
    Map<String, List<double>> temp = {};
    
    // expects rawValues to be Map<String, List<dynamic>>
    params.forEach((param, rawValues) {
      List<dynamic> decodedValues = rawValues.values.toList();
      List<double> list = decodedValues.map((num) => num as double).toList();
      temp[param] = list;
    });
    return NasaPayload(temps: temp);
  }
}

class HttpDataRetriever {

  Future<NasaPayload> getNasaData({
    required double lat,
    required double lng,
    required List<String> params
  }) async {
    String url = "https://power.larc.nasa.gov/api/temporal/monthly/point?parameters=${params.join(",")}"
        "&community=SB&longitude=$lng"
        "&latitude=$lat"
        "&format=JSON&start=2021&end=2021";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // print("httpDispatcher/getData: response ${response.statusCode} ${response.body}");
      final payload = NasaPayload.fromJson(jsonDecode(response.body));
      // print("httpDispatcher/getData: ${payload.temps}");
      return payload;
    } else {
      throw Exception('Failed to load NASA Power API');
    }
  }

}
