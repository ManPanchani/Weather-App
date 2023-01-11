import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class WeatherAPIHelper {
  WeatherAPIHelper._();
  static final WeatherAPIHelper weatherAPIHelper = WeatherAPIHelper._();

  Future<Weather?> fetchWeatherData({required String city}) async {
    const String baseURL = "https://api.openweathermap.org/data/2.5";
    final String endPOINT =
        "/weather?q=$city&appid=133e505f47d073df8f554fad35c0688a";

    http.Response res = await http.get(Uri.parse(baseURL + endPOINT));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(res.body);

      Weather weather = Weather.fromJSON(data: decodedData);

      return weather;
    }
    return null;
  }
}
