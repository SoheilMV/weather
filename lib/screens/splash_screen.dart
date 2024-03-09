import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_test/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
    ).then(
      (value) async {
        String city = 'tehran';
        var sp = await SharedPreferences.getInstance();
        if (sp.get('city') != null) {
          city = sp.get('city').toString();
        }
        Get.offAll(() => HomeScreen(city: city));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
            child: Text(
          'Splash Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
