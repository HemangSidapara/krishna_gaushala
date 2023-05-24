import 'dart:convert';

/// code : "200"
/// msg : "PDF Delete Successfully..."

DeletePdfModel deletePdfModelFromJson(String str) => DeletePdfModel.fromJson(json.decode(str));
String deletePdfModelToJson(DeletePdfModel data) => json.encode(data.toJson());

class DeletePdfModel {
  DeletePdfModel({
    String? code,
    String? msg,
  }) {
    _code = code;
    _msg = msg;
  }

  DeletePdfModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }
  String? _code;
  String? _msg;
  DeletePdfModel copyWith({
    String? code,
    String? msg,
  }) =>
      DeletePdfModel(
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
