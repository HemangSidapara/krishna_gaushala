import 'dart:convert';
/// code : "200"
/// msg : "Bill Fetch Successfully..."
/// Data : [{"bill_id":"1","name":"julm\nduniya","amount":"2010101","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/upload/1.pdf","type":"General","datetime":"2023-04-30\n13:33:26"}]

GetBillingModel getBillingModelFromJson(String str) => GetBillingModel.fromJson(json.decode(str));
String getBillingModelToJson(GetBillingModel data) => json.encode(data.toJson());
class GetBillingModel {
  GetBillingModel({
      String? code, 
      String? msg, 
      List<Data>? data,}){
    _code = code;
    _msg = msg;
    _data = data;
}

  GetBillingModel.fromJson(dynamic json) {
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
GetBillingModel copyWith({  String? code,
  String? msg,
  List<Data>? data,
}) => GetBillingModel(  code: code ?? _code,
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

/// bill_id : "1"
/// name : "julm\nduniya"
/// amount : "2010101"
/// url : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/upload/1.pdf"
/// type : "General"
/// datetime : "2023-04-30\n13:33:26"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? billId, 
      String? name, 
      String? amount, 
      String? url, 
      String? type, 
      String? datetime,}){
    _billId = billId;
    _name = name;
    _amount = amount;
    _url = url;
    _type = type;
    _datetime = datetime;
}

  Data.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _amount = json['amount'];
    _url = json['url'];
    _type = json['type'];
    _datetime = json['datetime'];
  }
  String? _billId;
  String? _name;
  String? _amount;
  String? _url;
  String? _type;
  String? _datetime;
Data copyWith({  String? billId,
  String? name,
  String? amount,
  String? url,
  String? type,
  String? datetime,
}) => Data(  billId: billId ?? _billId,
  name: name ?? _name,
  amount: amount ?? _amount,
  url: url ?? _url,
  type: type ?? _type,
  datetime: datetime ?? _datetime,
);
  String? get billId => _billId;
  String? get name => _name;
  String? get amount => _amount;
  String? get url => _url;
  String? get type => _type;
  String? get datetime => _datetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['amount'] = _amount;
    map['url'] = _url;
    map['type'] = _type;
    map['datetime'] = _datetime;
    return map;
  }

}