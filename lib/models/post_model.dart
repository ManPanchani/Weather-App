import 'package:flutter/material.dart';

class Weather {
  final String main;
  final String description;
  final double temp;
  final int humidity;
  final double speed;
  final String country;

  Weather({
    required this.main,
    required this.description,
    required this.temp,
    required this.humidity,
    required this.speed,
    required this.country,
  });

  factory Weather.fromJSON({required Map<String, dynamic> data}) {
    return Weather(
      main: data['weather'][0]['main'],
      description: data['weather'][0]['description'],
      temp: data['main']['temp'],
      humidity: data['main']['humidity'],
      speed: data['wind']['speed'],
      country: data['sys']['country'],
    );
  }
}
