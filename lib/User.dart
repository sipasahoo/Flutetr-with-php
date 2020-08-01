class User {
  String id;
  String username;
  String useremail;
  String password;
  User({this.id, this.username, this.useremail, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['user_name'] as String,
      useremail: json['user_email'] as String,
      password: json['user_password'] as String,
    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["user_name"] = username;
    map["user_email"] = useremail;
    map["user_password"] = password;
    return map;
  }
}
