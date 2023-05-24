import 'dart:convert';

/// code : "200"
/// msg : "Delete Data Successfully..."

DeleteSpendsModel deleteSpendsModelFromJson(String str) => DeleteSpendsModel.fromJson(json.decode(str));
String deleteSpendsModelToJson(DeleteSpendsModel data) => json.encode(data.toJson());

class DeleteSpendsModel {
  DeleteSpendsModel({
    String? code,
    String? msg,
  }) {
    _code = code;
    _msg = msg;
  }

  DeleteSpendsModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }
  String? _code;
  String? _msg;
  DeleteSpendsModel copyWith({
    String? code,
    String? msg,
  }) =>
      DeleteSpendsModel(
        code: code ?? _code,
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
