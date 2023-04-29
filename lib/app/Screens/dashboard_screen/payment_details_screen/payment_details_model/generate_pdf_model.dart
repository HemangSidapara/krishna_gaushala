import 'dart:convert';
/// code : "200"
/// msg : "PDF Generate Successfully..."
/// PATH : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/upload/0.pdf"

GeneratePdfModel generatePdfModelFromJson(String str) => GeneratePdfModel.fromJson(json.decode(str));
String generatePdfModelToJson(GeneratePdfModel data) => json.encode(data.toJson());
class GeneratePdfModel {
  GeneratePdfModel({
      String? code, 
      String? msg, 
      String? path,}){
    _code = code;
    _msg = msg;
    _path = path;
}

  GeneratePdfModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _path = json['PATH'];
  }
  String? _code;
  String? _msg;
  String? _path;
GeneratePdfModel copyWith({  String? code,
  String? msg,
  String? path,
}) => GeneratePdfModel(  code: code ?? _code,
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