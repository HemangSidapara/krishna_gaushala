import 'dart:convert';
/// code : "200"
/// msg : "Data Fetch Successfully..."
/// Data : [{"spend_id":"1","amount":"2000","spend_to":"Test\nAmount","notes":"Niran Seva Mate Use Karel che ","datetime":"27-04-2023\n03:44:24"},{"spend_id":"6","amount":"5000","spend_to":"Milan Patel","notes":"Niran Seva Mate Use Karel che\n\t\t\t\t\t\t\t\t\t\t\t\t\t","datetime":"28-04-2023 05:48:11"},{"spend_id":"7","amount":"100000","spend_to":"Shiv\nkatha","notes":"\t\t\t\t\t\t\t\t","datetime":"28-04-2023\n04:45:38"},{"spend_id":"8","amount":"100","spend_to":"RJ","notes":"Abcd","datetime":"29-04-2023\n11:26:07"},{"spend_id":"9","amount":"500","spend_to":"edf","notes":"asd","datetime":"29-04-2023\n11:33:15"},{"spend_id":"10","amount":"500","spend_to":"edf","notes":"asd","datetime":"29-04-2023 11:33:47"}]

GetSpendsModel getSpendsModelFromJson(String str) => GetSpendsModel.fromJson(json.decode(str));
String getSpendsModelToJson(GetSpendsModel data) => json.encode(data.toJson());
class GetSpendsModel {
  GetSpendsModel({
      String? code, 
      String? msg, 
      List<Data>? data,}){
    _code = code;
    _msg = msg;
    _data = data;
}

  GetSpendsModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _code;
  String? _msg;
  List<Data>? _data;
GetSpendsModel copyWith({  String? code,
  String? msg,
  List<Data>? data,
}) => GetSpendsModel(  code: code ?? _code,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get code => _code;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// spend_id : "1"
/// amount : "2000"
/// spend_to : "Test\nAmount"
/// notes : "Niran Seva Mate Use Karel che "
/// datetime : "27-04-2023\n03:44:24"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? spendId, 
      String? amount, 
      String? spendTo, 
      String? notes, 
      String? datetime,}){
    _spendId = spendId;
    _amount = amount;
    _spendTo = spendTo;
    _notes = notes;
    _datetime = datetime;
}

  Data.fromJson(dynamic json) {
    _spendId = json['spend_id'];
    _amount = json['amount'];
    _spendTo = json['spend_to'];
    _notes = json['notes'];
    _datetime = json['datetime'];
  }
  String? _spendId;
  String? _amount;
  String? _spendTo;
  String? _notes;
  String? _datetime;
Data copyWith({  String? spendId,
  String? amount,
  String? spendTo,
  String? notes,
  String? datetime,
}) => Data(  spendId: spendId ?? _spendId,
  amount: amount ?? _amount,
  spendTo: spendTo ?? _spendTo,
  notes: notes ?? _notes,
  datetime: datetime ?? _datetime,
);
  String? get spendId => _spendId;
  String? get amount => _amount;
  String? get spendTo => _spendTo;
  String? get notes => _notes;
  String? get datetime => _datetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['spend_id'] = _spendId;
    map['amount'] = _amount;
    map['spend_to'] = _spendTo;
    map['notes'] = _notes;
    map['datetime'] = _datetime;
    return map;
  }

}