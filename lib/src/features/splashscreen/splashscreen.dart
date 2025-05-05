import 'dart:async';

import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/homepage/home.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/login/login.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/api.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/connectivity.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/hive_localstorage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    getInfromationInternet();
    navigateToNextScreen();
    super.initState();
  }

  getInfromationInternet() async {
    isNetworkAvailable = await checkIsNetworkAvailable();
    setState(() {});
  }

  setStateNoInternet() {
    getInfromationInternet();
    setState(() {});
  }

  navigateToNextScreen() async {
    Timer(const Duration(milliseconds: 3000), () async {
      final user = await getUserData();

      if (user != null) {
        Auth.userID = user.userID;
        Auth.name = user.name;
        Auth.email = user.email;
        Auth.password = user.password;
        Auth.accestoken = user.accestoken;
        Auth.whatsappNumber = user.whatsappNumber;
        Auth.empCode = user.empCode;
        Auth.roleId = user.roleId;
        Auth.role = user.role;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/konarklogo.png')));
  }
}
