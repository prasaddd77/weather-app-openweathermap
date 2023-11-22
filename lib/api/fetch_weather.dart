import 'dart:convert';

import 'package:weatherapp/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather_data_current.dart';
import 'package:weatherapp/model/weather_data_daily.dart';
import 'package:weatherapp/model/weather_data_hourly.dart';
import 'package:weatherapp/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  // procecssing the data from response -> to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);

      if (jsonString != null && jsonString is Map<String, dynamic>) {
        weatherData = WeatherData(
          WeatherDataCurrent.fromJson(jsonString),
          WeatherDataHourly.fromJson(jsonString),
          WeatherDataDaily.fromJson(jsonString),
        );
        return weatherData!;
      } else {
        throw Exception("Invalid JSON format in response");
      }
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }
}
