import 'package:flutter/material.dart';
import 'package:flutter_php/LoginScreen.dart';
import 'package:flutter_php/Service.dart';
import 'package:flutter_php/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterUser extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<RegisterUser> {
  bool visible = false;
  List<User> _users;
  final _formKey = GlobalKey<FormState>();
  // Getting value from TextField widget.

  String name;
  String email;
  String password;
  FocusNode myFocusNode;
  bool _autoValidate = false;

  _addUser() {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      print('Empty Fields');
      return;
    }
     Services.getExistUser(email).then((users) {
      setState(() {
        _users = users.cast<User>();
        if (_users.length > 0) {
          Fluttertoast.showToast(
              msg: 'User already Exist',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }
        else{
            Services.addUser(name, email, password).then((result) {
             Fluttertoast.showToast(
              msg: 'User Added Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white);
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          });
        }
      });
    });
   
  }

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter Name";
    } else {
      return null;
    }
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter Password";
    } else {
      return null;
    }
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
  

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Text forms was validated.
      form.save();
       _addUser();
    
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
                              child: new TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Name'),
                                onSaved: (String value) {
                                  name = value;
                                },
                                validator: _validateName,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(17),
                              child: TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Email'),
                                onSaved: (String value) {
                                  email = value;
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
                                    child: Text('Sign Up'),
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
