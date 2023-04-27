import 'dart:convert';
/// code : "200"
/// msg : "Login Sucessfully..."

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());
class LoginModel {
  LoginModel({
      String? code, 
      String? msg,}){
    _code = code;
    _msg = msg;
}

  LoginModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }
  String? _code;
  String? _msg;
LoginModel copyWith({  String? code,
  String? msg,
}) => LoginModel(  code: code ?? _code,
  msg: msg ?? _msg,
);
  String? get code => _code;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    return map;
  }

}