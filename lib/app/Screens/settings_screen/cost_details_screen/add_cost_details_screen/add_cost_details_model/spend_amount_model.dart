import 'dart:convert';
/// code : "200"
/// msg : "Send Data Successfully..."

SpendAmountModel spendAmountModelFromJson(String str) => SpendAmountModel.fromJson(json.decode(str));
String spendAmountModelToJson(SpendAmountModel data) => json.encode(data.toJson());
class SpendAmountModel {
  SpendAmountModel({
      String? code, 
      String? msg,}){
    _code = code;
    _msg = msg;
}

  SpendAmountModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }
  String? _code;
  String? _msg;
SpendAmountModel copyWith({  String? code,
  String? msg,
}) => SpendAmountModel(  code: code ?? _code,
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