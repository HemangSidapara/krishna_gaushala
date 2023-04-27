import 'dart:convert';
/// code : "200"
/// msg : [{"id":"1","type":"General"},{"id":"2","type":"Niran"},{"id":"3","type":"Gau\nDohan"},{"id":"4","type":"Vahan Vyavastha"},{"id":"5","type":"Sarvar"},{"id":"6","type":"Makan Bandhkam"}]

GetTypesModel getTypesModelFromJson(String str) => GetTypesModel.fromJson(json.decode(str));
String getTypesModelToJson(GetTypesModel data) => json.encode(data.toJson());
class GetTypesModel {
  GetTypesModel({
      String? code, 
      List<Msg>? msg,}){
    _code = code;
    _msg = msg;
}

  GetTypesModel.fromJson(dynamic json) {
    _code = json['code'];
    if (json['msg'] != null) {
      _msg = [];
      json['msg'].forEach((v) {
        _msg?.add(Msg.fromJson(v));
      });
    }
  }
  String? _code;
  List<Msg>? _msg;
GetTypesModel copyWith({  String? code,
  List<Msg>? msg,
}) => GetTypesModel(  code: code ?? _code,
  msg: msg ?? _msg,
);
  String? get code => _code;
  List<Msg>? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_msg != null) {
      map['msg'] = _msg?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// type : "General"

Msg msgFromJson(String str) => Msg.fromJson(json.decode(str));
String msgToJson(Msg data) => json.encode(data.toJson());
class Msg {
  Msg({
      String? id, 
      String? type,}){
    _id = id;
    _type = type;
}

  Msg.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
  }
  String? _id;
  String? _type;
Msg copyWith({  String? id,
  String? type,
}) => Msg(  id: id ?? _id,
  type: type ?? _type,
);
  String? get id => _id;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    return map;
  }

}