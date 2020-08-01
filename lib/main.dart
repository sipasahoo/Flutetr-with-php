import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_php/ChatScreen.dart';
import 'dart:async';
import 'package:flutter_php/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email == null ? MyApp() : ChatScreen()));
}
// void main() {
//   runApp(new MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//       primaryColor: Colors.lightBlue[800],
//       accentColor: Colors.cyan[600],
//       fontFamily: 'Georgia',
//       textTheme: TextTheme(
//         headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//         headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//         bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
//       ),
//     ),
//     home: new MyApp(),
//   ));
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Fixing App Orientation.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          hintColor: Colors.white,
          inputDecorationTheme: new InputDecorationTheme(
              labelStyle: new TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0)))),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) => new LoginScreen()
      },
    );
  }
}
class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
// THIS FUNCTION WILL NAVIGATE FROM SPLASH SCREEN TO HOME SCREEN.    // USING NAVIGATOR CLASS.

  void navigationToNextPage() {
    Navigator.pushNamed(context, '/HomePage');
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    // To make this screen full screen.
    // It will hide status bar and notch.
    SystemChrome.setEnabledSystemUIOverlays([]);

    // full screen image for splash screen.
    return Center(
      child: new Image.asset(
        'images/splash.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
