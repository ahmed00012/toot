import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toot/data/local_storage.dart';
import 'package:toot/presentation/widgets/buttom_nav_bar.dart';

import 'introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  checkFirstSeen() async {
    Position? position = await Geolocator.getLastKnownPosition();
    LocalStorage.saveData(key: 'long', value: position!.longitude);
    LocalStorage.saveData(key: 'lat', value: position.latitude);

    Timer(Duration(seconds: 2), () async {
      if (await FlutterSecureStorage().read(key: 'token') == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => IntroductionScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => BottomNavBar()),
        );
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.contain,
          height: 0.23.sh,
          width: 0.5.sw,
        ),
      ),
    );
  }
}
