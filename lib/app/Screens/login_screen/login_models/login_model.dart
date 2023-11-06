import 'dart:convert';

/// code : "200"
/// msg : "Login Successfully..."
/// user_id : "2"

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    String? code,
    String? msg,
    String? userId,
  }) {
    _code = code;
    _msg = msg;
    _userId = userId;
  }

  LoginModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _userId = json['user_id'];
  }
  String? _code;
  String? _msg;
  String? _userId;
  LoginModel copyWith({
    String? code,
    String? msg,
    String? userId,
  }) =>
      LoginModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        userId: userId ?? _userId,
      );
  String? get code => _code;
  String? get msg => _msg;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['user_id'] = _userId;
    return map;
  }
}
