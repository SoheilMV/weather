import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapi/weatherapi.dart';

class HomeController extends GetxController {
  final String city;
  final TextEditingController txtSearch = TextEditingController();
  final WeatherRequest _weatherapi =
      WeatherRequest('d1e8d41f0a724ce8a4f114656240603');
  ForecastWeather? data;

  HomeController({required this.city});

  Future<void> getData(String name) async {
    try {
      data = await _weatherapi.getForecastWeatherByCityName(name);
      if (data != null) {
        var sp = await SharedPreferences.getInstance();
        sp.setString('city', name);
        update();
      }
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData(city);
  }
}
