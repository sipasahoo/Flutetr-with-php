import 'dart:convert';
import 'package:http/http.dart' as http;
import 'User.dart';

class Services {
  static const ROOT = 'http://192.168.43.19/flutter/flutter.php';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _GET_EXIST_USER = 'GET_EXIST_USER';
  static const _GET_LOGIN_USER = 'GET_LOGIN_USER';
  static const _ADD_EMP_ACTION = 'ADD_USER';
  //static const _UPDATE_EMP_ACTION = 'UPDATE_USER';
  //static const _DELETE_EMP_ACTION = 'DELETE_USER';
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

  // Method to update an Employee in Database...
  // static Future<String> updateEmployee(
  //     String empId, String firstName, String lastName) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _UPDATE_EMP_ACTION;
  //     map['emp_id'] = empId;
  //     map['first_name'] = firstName;
  //     map['last_name'] = lastName;
  //     final response = await http.post(ROOT, body: map);
  //     print('updateEmployee Response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       return response.body;
  //     } else {
  //       return "error";
  //     }
  //   } catch (e) {
  //     return "error";
  //   }
  // }

  // // Method to Delete an Employee from Database...
  // static Future<String> deleteEmployee(String empId) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = _DELETE_EMP_ACTION;
  //     map['emp_id'] = empId;
  //     final response = await http.post(ROOT, body: map);
  //     print('deleteEmployee Response: ${response.body}');
  //     if (200 == response.statusCode) {
  //       return response.body;
  //     } else {
  //       return "error";
  //     }
  //   } catch (e) {
  //     return "error"; // returning just an "error" string to keep this simple...
  //   }
  // }
}
