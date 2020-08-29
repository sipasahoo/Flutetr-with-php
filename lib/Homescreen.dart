import 'package:flutter/material.dart';
import 'package:flutter_php/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomeScreen> {
  TextEditingController txtControler;
  FocusNode myFocusNode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[900],
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RaisedButton(
                        onPressed: () async{
                          //Auth.of(context).logout();
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.push (
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: const Text('LOGOUT'),
                      ),
                      ])),
            ),
            
          ]),
        ),
      ),
    );
  }
}