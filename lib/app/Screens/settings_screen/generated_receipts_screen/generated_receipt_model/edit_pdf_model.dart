import 'dart:convert';
/// code : "200"
/// msg : "PDF Generate Successfully..."
/// PATH : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/upload/8.pdf"

EditPdfModel editPdfModelFromJson(String str) => EditPdfModel.fromJson(json.decode(str));
String editPdfModelToJson(EditPdfModel data) => json.encode(data.toJson());
class EditPdfModel {
  EditPdfModel({
      String? code, 
      String? msg, 
      String? path,}){
    _code = code;
    _msg = msg;
    _path = path;
}

  EditPdfModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _path = json['PATH'];
  }
  String? _code;
  String? _msg;
  String? _path;
EditPdfModel copyWith({  String? code,
  String? msg,
  String? path,
}) => EditPdfModel(  code: code ?? _code,
  msg: msg ?? _msg,
  path: path ?? _path,
);
  String? get code => _code;
  String? get msg => _msg;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['PATH'] = _path;
    return map;
  }

}