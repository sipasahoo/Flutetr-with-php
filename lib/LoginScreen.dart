import 'package:flutter/material.dart';
import 'package:flutter_php/ChatScreen.dart';
import 'package:flutter_php/Registration.dart';
import 'package:flutter_php/Service.dart';
import 'package:flutter_php/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _autoValidate = false;
  List<User> _users;

  void initState() {
    super.initState();
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);
    Services.getExistUser(value).then((users) {
      setState(() {
        email = value;
        _users = users.cast<User>();
        if (_users.length == 0) {
          Fluttertoast.showToast(
              msg: 'Invalid UserId',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
      });
    });
    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }
    // The pattern of the email didn't match the regex above.
    return 'Emailid does not valid';
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Enter password";
    } else {
      setState(() {
        password = value;
      });
      return null;
    }
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      Services.getLoginUser(email, password).then((users) {
        // ignore: missing_return
        setState(() async {
          _users = users.cast<User>();
          if (_users.length > 0 && _users != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', email);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          } else {
            Fluttertoast.showToast(
                msg: 'Invalid Authentication',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white);
          }
        });
      });
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[900],
      body: SingleChildScrollView(
          child: new Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "MOMENTUM",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 28.0,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0)),
                        Text(
                          "GROWTH . HAPPENS . TODAY",
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ])),
            ),
            Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Text("SIGN IN",
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                        ),
                        InkWell(
                          child: Text("SIGN UP",
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterUser()),
                            );
                          },
                        ),
                      ],
                    ))),
            Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(17),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    labelText: 'Email'),
                                onSaved: (String value) {
                                  email = value;
                                  setState(() {
                                    email = value;
                                  });
                                },
                                validator: _validateEmail,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    labelText: 'Password'),
                                onSaved: (String value) {
                                  password = value;
                                },
                                validator: _validatePassword,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 50.0,
                                  child: RaisedButton(
                                    onPressed: _validateInputs,
                                    child: Text('Signin'),
                                    textColor: Colors.white,
                                    color: Colors.cyan[800],
                                  )),
                            )
                          ],
                        ))))
          ],
        ),
      )),
    );
  }
}
