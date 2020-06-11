import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:clima/services/location.dart';

const kopenWeatherMapAPIKey = '6db913644d49e601c3b888a818caaf0f';
const kopenWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    http.Response resp = await http.get(
        '$kopenWeatherMapURL?units=metric&q=$cityName&appid=$kopenWeatherMapAPIKey');

    if (resp.statusCode == 200) {
      return convert.jsonDecode(resp.body);
    } else {
      print(resp.statusCode);
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    http.Response resp = await http.get(
        '$kopenWeatherMapURL?units=metric&lat=${location.latitude}&lon=${location.longitude}&appid=$kopenWeatherMapAPIKey');

    if (resp.statusCode == 200) {
      return convert.jsonDecode(resp.body);
    } else {
      print(resp.statusCode);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
