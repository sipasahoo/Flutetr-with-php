import 'dart:convert';
import 'package:http/http.dart' as http;
import 'User.dart';

class Services {
  static const ROOT = 'flutter.php';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _GET_EXIST_USER = 'GET_EXIST_USER';
  static const _GET_LOGIN_USER = 'GET_LOGIN_USER';
  static const _ADD_EMP_ACTION = 'ADD_USER';
  static Future<List<User>> getLoginUser(useremail, password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_LOGIN_USER;
      map['email'] = useremail;
      map['password'] = password;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>(); // return an empty list on exception/error
    }
  }

  static Future<List<User>> getExistUser(useremail) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_EXIST_USER;
      map['email'] = useremail;
      final response = await http.post(ROOT, body: map);
      //print('get Response: ${response.body}');
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>(); // return an empty list on exception/error
    }
  }

  static Future<List<User>> getUser() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('get Response: ${response.body}');
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>(); // return an empty list on exception/error
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> addUser(
      String firstName, String email, String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['user_name'] = firstName;
      map['user_email'] = email;
      map['user_password'] = password;
      final response = await http.post(ROOT, body: map);
      print('adduser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
