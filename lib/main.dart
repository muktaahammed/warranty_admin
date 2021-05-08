import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warranty_admin/dashboard/official_dash.dart';
import 'package:warranty_admin/login_screens/login_screen.dart';
import 'package:warranty_admin/login_screens/second_login.dart';
import 'package:warranty_admin/provider/auth_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      //SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      if (prefs.containsKey("email")) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OriginalDashBoard(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) => SecondLogin(),
          ),
        );
      }
    } else {
      prefs.setBool('seen', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: FlutterLogo(size: MediaQuery.of(context).size.height),
    );
  }
}

// rewsserve
/* class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: FlutterLogo(size: MediaQuery.of(context).size.height),
    );
  }
}
 */
