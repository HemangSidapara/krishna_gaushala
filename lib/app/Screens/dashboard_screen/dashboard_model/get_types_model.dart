import 'dart:convert';
/// code : "200"
/// Data : [{"type":"General","id":"1"},{"type":"Niran","id":"2"},{"type":"Gau Dohan","id":"3"},{"type":"Vahan Vyavastha","id":"4"},{"type":"Sarvar","id":"5"},{"type":"Makan Bandhkam","id":"6"}]
/// msg : "Types Fetch Successfully..."

GetTypesModel getTypesModelFromJson(String str) => GetTypesModel.fromJson(json.decode(str));
String getTypesModelToJson(GetTypesModel data) => json.encode(data.toJson());
class GetTypesModel {
  GetTypesModel({
      String? code, 
      List<Data>? data, 
      String? msg,}){
    _code = code;
    _data = data;
    _msg = msg;
}

  GetTypesModel.fromJson(dynamic json) {
    _code = json['code'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _msg = json['msg'];
  }
  String? _code;
  List<Data>? _data;
  String? _msg;
GetTypesModel copyWith({  String? code,
  List<Data>? data,
  String? msg,
}) => GetTypesModel(  code: code ?? _code,
  data: data ?? _data,
  msg: msg ?? _msg,
);
  String? get code => _code;
  List<Data>? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = _msg;
    return map;
  }

}

/// type : "General"
/// id : "1"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? type, 
      String? id,}){
    _type = type;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _type = json['type'];
    _id = json['id'];
  }
  String? _type;
  String? _id;
Data copyWith({  String? type,
  String? id,
}) => Data(  type: type ?? _type,
  id: id ?? _id,
);
  String? get type => _type;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['id'] = _id;
    return map;
  }

}