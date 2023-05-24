import 'dart:convert';

/// code : "200"
/// msg : "Send Data Successfully..."

EditSpendsModel editSpendsModelFromJson(String str) => EditSpendsModel.fromJson(json.decode(str));
String editSpendsModelToJson(EditSpendsModel data) => json.encode(data.toJson());

class EditSpendsModel {
  EditSpendsModel({
    String? code,
    String? msg,
  }) {
    _code = code;
    _msg = msg;
  }

  EditSpendsModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }
  String? _code;
  String? _msg;
  EditSpendsModel copyWith({
    String? code,
    String? msg,
  }) =>
      EditSpendsModel(
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
