import 'dart:convert';

/// code : "200"
/// msg : "get Bill Successfully"
/// Data : {"Receipt":[{"bill_id":"1","name":"????","amount":"1000","address":"Rajkot","type":"Yes","type1":"Yes","type2":"No","cash":"No","cheque_number":"123456789","cheque_date":"12/12/2023","bank":"SBI BANK","branch":"Mavdi Main Road","account_number":"123456789","pan_number":"123456789","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Receipt/1.pdf","datetime":"2023-06-06 07:21:41"}],"Niran":[{"bill_id":"1","name":"???? patel","amount":"1000","quantity":"10 ???? ???","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Niran/1.pdf","datetime":"2023-06-06 07:21:20"}],"Gau Dohan":[{"bill_id":"1","name":"Gaurav","amount":"1000","quantity":"30 days","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/GauDohan/1.pdf","datetime":"2023-06-06 07:21:31"}],"Vahan Vyavastha":[{"bill_id":"2","name":"Gaurav ????","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/VahanVyavastha/2.pdf","datetime":"2023-06-06 07:21:16"},{"bill_id":"1","name":"Gaurav","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/VahanVyavastha/","datetime":"2023-06-05 06:32:04"}],"Sarvar":[{"bill_id":"1","name":"Gaurav Patel","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Sarvar/1.pdf","datetime":"2023-06-06 07:20:58"}],"Makan Bandhkam":[{"bill_id":"2","name":"????","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/MakanBandhkam/2.pdf","datetime":"2023-06-06 07:20:54"}],"Band Party":[{"bill_id":"1","name":"Gaurav Patel","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/BandParty/1.pdf","datetime":"2023-06-06 07:20:22"}]}

GetBillingModel getBillingModelFromJson(String str) => GetBillingModel.fromJson(json.decode(str));
String getBillingModelToJson(GetBillingModel data) => json.encode(data.toJson());

class GetBillingModel {
  GetBillingModel({
    String? code,
    String? msg,
    Data? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetBillingModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }
  String? _code;
  String? _msg;
  Data? _data;
  GetBillingModel copyWith({
    String? code,
    String? msg,
    Data? data,
  }) =>
      GetBillingModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );
  String? get code => _code;
  String? get msg => _msg;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['Data'] = _data?.toJson();
    }
    return map;
  }
}

/// Receipt : [{"bill_id":"1","name":"????","amount":"1000","address":"Rajkot","type":"Yes","type1":"Yes","type2":"No","cash":"No","cheque_number":"123456789","cheque_date":"12/12/2023","bank":"SBI BANK","branch":"Mavdi Main Road","account_number":"123456789","pan_number":"123456789","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Receipt/1.pdf","datetime":"2023-06-06 07:21:41"}]
/// Niran : [{"bill_id":"1","name":"???? patel","amount":"1000","quantity":"10 ???? ???","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Niran/1.pdf","datetime":"2023-06-06 07:21:20"}]
/// Gau Dohan : [{"bill_id":"1","name":"Gaurav","amount":"1000","quantity":"30 days","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/GauDohan/1.pdf","datetime":"2023-06-06 07:21:31"}]
/// Vahan Vyavastha : [{"bill_id":"2","name":"Gaurav ????","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/VahanVyavastha/2.pdf","datetime":"2023-06-06 07:21:16"},{"bill_id":"1","name":"Gaurav","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/VahanVyavastha/","datetime":"2023-06-05 06:32:04"}]
/// Sarvar : [{"bill_id":"1","name":"Gaurav Patel","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Sarvar/1.pdf","datetime":"2023-06-06 07:20:58"}]
/// Makan Bandhkam : [{"bill_id":"2","name":"????","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/MakanBandhkam/2.pdf","datetime":"2023-06-06 07:20:54"}]
/// Band Party : [{"bill_id":"1","name":"Gaurav Patel","amount":"1000","url":"https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/BandParty/1.pdf","datetime":"2023-06-06 07:20:22"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    List<Receipt>? receipt,
    List<Niran>? niran,
    List<GauDohan>? gauDohan,
    List<VahanVyavastha>? vahanVyavastha,
    List<Sarvar>? sarvar,
    List<MakanBandhkam>? makanBandhkam,
    List<BandParty>? bandParty,
  }) {
    _receipt = receipt;
    _niran = niran;
    _gauDohan = gauDohan;
    _vahanVyavastha = vahanVyavastha;
    _sarvar = sarvar;
    _makanBandhkam = makanBandhkam;
    _bandParty = bandParty;
  }

  Data.fromJson(dynamic json) {
    if (json['Receipt'] != null) {
      _receipt = [];
      json['Receipt'].forEach((v) {
        _receipt?.add(Receipt.fromJson(v));
      });
    }
    if (json['Niran'] != null) {
      _niran = [];
      json['Niran'].forEach((v) {
        _niran?.add(Niran.fromJson(v));
      });
    }
    if (json['Gau Dohan'] != null) {
      _gauDohan = [];
      json['Gau Dohan'].forEach((v) {
        _gauDohan?.add(GauDohan.fromJson(v));
      });
    }
    if (json['Vahan Vyavastha'] != null) {
      _vahanVyavastha = [];
      json['Vahan Vyavastha'].forEach((v) {
        _vahanVyavastha?.add(VahanVyavastha.fromJson(v));
      });
    }
    if (json['Sarvar'] != null) {
      _sarvar = [];
      json['Sarvar'].forEach((v) {
        _sarvar?.add(Sarvar.fromJson(v));
      });
    }
    if (json['Makan Bandhkam'] != null) {
      _makanBandhkam = [];
      json['Makan Bandhkam'].forEach((v) {
        _makanBandhkam?.add(MakanBandhkam.fromJson(v));
      });
    }
    if (json['Band Party'] != null) {
      _bandParty = [];
      json['Band Party'].forEach((v) {
        _bandParty?.add(BandParty.fromJson(v));
      });
    }
  }
  List<Receipt>? _receipt;
  List<Niran>? _niran;
  List<GauDohan>? _gauDohan;
  List<VahanVyavastha>? _vahanVyavastha;
  List<Sarvar>? _sarvar;
  List<MakanBandhkam>? _makanBandhkam;
  List<BandParty>? _bandParty;
  Data copyWith({
    List<Receipt>? receipt,
    List<Niran>? niran,
    List<GauDohan>? gauDohan,
    List<VahanVyavastha>? vahanVyavastha,
    List<Sarvar>? sarvar,
    List<MakanBandhkam>? makanBandhkam,
    List<BandParty>? bandParty,
  }) =>
      Data(
        receipt: receipt ?? _receipt,
        niran: niran ?? _niran,
        gauDohan: gauDohan ?? _gauDohan,
        vahanVyavastha: vahanVyavastha ?? _vahanVyavastha,
        sarvar: sarvar ?? _sarvar,
        makanBandhkam: makanBandhkam ?? _makanBandhkam,
        bandParty: bandParty ?? _bandParty,
      );
  List<Receipt>? get receipt => _receipt;
  List<Niran>? get niran => _niran;
  List<GauDohan>? get gauDohan => _gauDohan;
  List<VahanVyavastha>? get vahanVyavastha => _vahanVyavastha;
  List<Sarvar>? get sarvar => _sarvar;
  List<MakanBandhkam>? get makanBandhkam => _makanBandhkam;
  List<BandParty>? get bandParty => _bandParty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_receipt != null) {
      map['Receipt'] = _receipt?.map((v) => v.toJson()).toList();
    }
    if (_niran != null) {
      map['Niran'] = _niran?.map((v) => v.toJson()).toList();
    }
    if (_gauDohan != null) {
      map['Gau Dohan'] = _gauDohan?.map((v) => v.toJson()).toList();
    }
    if (_vahanVyavastha != null) {
      map['Vahan Vyavastha'] = _vahanVyavastha?.map((v) => v.toJson()).toList();
    }
    if (_sarvar != null) {
      map['Sarvar'] = _sarvar?.map((v) => v.toJson()).toList();
    }
    if (_makanBandhkam != null) {
      map['Makan Bandhkam'] = _makanBandhkam?.map((v) => v.toJson()).toList();
    }
    if (_bandParty != null) {
      map['Band Party'] = _bandParty?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// bill_id : "1"
/// name : "Gaurav Patel"
/// amount : "1000"
/// url : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/BandParty/1.pdf"
/// datetime : "2023-06-06 07:20:22"

BandParty bandPartyFromJson(String str) => BandParty.fromJson(json.decode(str));
String bandPartyToJson(BandParty data) => json.encode(data.toJson());

class BandParty {
  BandParty({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? url,
    String? datetime,
    String? address,
  }) {
    _billId = billId;
    _name = name;
    _phone = phone;
    _amount = amount;
    _url = url;
    _datetime = datetime;
    _address = address;
  }

  BandParty.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _phone = json['phone'];
    _amount = json['amount'];
    _url = json['url'];
    _datetime = json['datetime'];
    _address = json['address'];
  }
  String? _billId;
  String? _name;
  String? _phone;
  String? _amount;
  String? _url;
  String? _datetime;
  String? _address;
  BandParty copyWith({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? url,
    String? datetime,
    String? address,
  }) =>
      BandParty(
        billId: billId ?? _billId,
        name: name ?? _name,
        phone: phone ?? _phone,
        amount: amount ?? _amount,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
        address: address ?? _address,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get url => _url;
  String? get datetime => _datetime;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['url'] = _url;
    map['datetime'] = _datetime;
    map['address'] = _address;
    return map;
  }
}

/// bill_id : "2"
/// name : "????"
/// amount : "1000"
/// url : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/MakanBandhkam/2.pdf"
/// datetime : "2023-06-06 07:20:54"

MakanBandhkam makanBandhkamFromJson(String str) => MakanBandhkam.fromJson(json.decode(str));
String makanBandhkamToJson(MakanBandhkam data) => json.encode(data.toJson());

class MakanBandhkam {
  MakanBandhkam({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? url,
    String? datetime,
    String? address,
  }) {
    _billId = billId;
    _name = name;
    _phone = phone;
    _amount = amount;
    _url = url;
    _datetime = datetime;
    _address = address;
  }

  MakanBandhkam.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _phone = json['phone'];
    _amount = json['amount'];
    _url = json['url'];
    _datetime = json['datetime'];
    _address = json['address'];
  }
  String? _billId;
  String? _name;
  String? _phone;
  String? _amount;
  String? _url;
  String? _datetime;
  String? _address;
  MakanBandhkam copyWith({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? url,
    String? datetime,
    String? address,
  }) =>
      MakanBandhkam(
        billId: billId ?? _billId,
        name: name ?? _name,
        phone: phone ?? _phone,
        amount: amount ?? _amount,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
        address: address ?? _address,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get url => _url;
  String? get datetime => _datetime;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['url'] = _url;
    map['datetime'] = _datetime;
    map['address'] = _address;
    return map;
  }
}

/// bill_id : "1"
/// name : "Gaurav Patel"
/// amount : "1000"
/// url : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Sarvar/1.pdf"
/// datetime : "2023-06-06 07:20:58"

Sarvar sarvarFromJson(String str) => Sarvar.fromJson(json.decode(str));
String sarvarToJson(Sarvar data) => json.encode(data.toJson());

class Sarvar {
  Sarvar({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? url,
    String? datetime,
    String? address,
  }) {
    _billId = billId;
    _name = name;
    _phone = phone;
    _amount = amount;
    _url = url;
    _datetime = datetime;
    _address = address;
  }

  Sarvar.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _phone = json['phone'];
    _amount = json['amount'];
    _url = json['url'];
    _datetime = json['datetime'];
    _address = json['address'];
  }
  String? _billId;
  String? _name;
  String? _phone;
  String? _amount;
  String? _url;
  String? _datetime;
  String? _address;
  Sarvar copyWith({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? url,
    String? datetime,
    String? address,
  }) =>
      Sarvar(
        billId: billId ?? _billId,
        name: name ?? _name,
        phone: phone ?? _phone,
        amount: amount ?? _amount,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
        address: address ?? _address,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get url => _url;
  String? get datetime => _datetime;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['url'] = _url;
    map['datetime'] = _datetime;
    map['address'] = _address;
    return map;
  }
}

/// bill_id : "2"
/// name : "Gaurav ????"
/// amount : "1000"
/// url : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/VahanVyavastha/2.pdf"
/// datetime : "2023-06-06 07:21:16"

VahanVyavastha vahanVyavasthaFromJson(String str) => VahanVyavastha.fromJson(json.decode(str));
String vahanVyavasthaToJson(VahanVyavastha data) => json.encode(data.toJson());

class VahanVyavastha {
  VahanVyavastha({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? url,
    String? datetime,
    String? address,
  }) {
    _billId = billId;
    _name = name;
    _phone = phone;
    _amount = amount;
    _url = url;
    _datetime = datetime;
    _address = address;
  }

  VahanVyavastha.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _phone = json['phone'];
    _amount = json['amount'];
    _url = json['url'];
    _datetime = json['datetime'];
    _address = json['address'];
  }
  String? _billId;
  String? _name;
  String? _phone;
  String? _amount;
  String? _url;
  String? _datetime;
  String? _address;
  VahanVyavastha copyWith({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? url,
    String? datetime,
    String? address,
  }) =>
      VahanVyavastha(
        billId: billId ?? _billId,
        name: name ?? _name,
        phone: phone ?? _phone,
        amount: amount ?? _amount,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
        address: address ?? _address,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get url => _url;
  String? get datetime => _datetime;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['url'] = _url;
    map['datetime'] = _datetime;
    map['address'] = _address;
    return map;
  }
}

/// bill_id : "1"
/// name : "Gaurav"
/// amount : "1000"
/// quantity : "30 days"
/// url : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/GauDohan/1.pdf"
/// datetime : "2023-06-06 07:21:31"

GauDohan gauDohanFromJson(String str) => GauDohan.fromJson(json.decode(str));
String gauDohanToJson(GauDohan data) => json.encode(data.toJson());

class GauDohan {
  GauDohan({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? quantity,
    String? url,
    String? datetime,
    String? address,
  }) {
    _billId = billId;
    _name = name;
    _phone = phone;
    _amount = amount;
    _quantity = quantity;
    _url = url;
    _datetime = datetime;
    _address = address;
  }

  GauDohan.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _phone = json['phone'];
    _amount = json['amount'];
    _quantity = json['quantity'];
    _url = json['url'];
    _datetime = json['datetime'];
    _address = json['address'];
  }
  String? _billId;
  String? _name;
  String? _phone;
  String? _amount;
  String? _quantity;
  String? _url;
  String? _datetime;
  String? _address;
  GauDohan copyWith({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? quantity,
    String? url,
    String? datetime,
    String? address,
  }) =>
      GauDohan(
        billId: billId ?? _billId,
        name: name ?? _name,
        phone: phone ?? _phone,
        amount: amount ?? _amount,
        quantity: quantity ?? _quantity,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
        address: address ?? _address,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get quantity => _quantity;
  String? get url => _url;
  String? get datetime => _datetime;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['quantity'] = _quantity;
    map['url'] = _url;
    map['datetime'] = _datetime;
    map['address'] = _address;
    return map;
  }
}

/// bill_id : "1"
/// name : "???? patel"
/// amount : "1000"
/// quantity : "10 ???? ???"
/// url : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Niran/1.pdf"
/// datetime : "2023-06-06 07:21:20"

Niran niranFromJson(String str) => Niran.fromJson(json.decode(str));
String niranToJson(Niran data) => json.encode(data.toJson());

class Niran {
  Niran({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? quantity,
    String? url,
    String? datetime,
    String? address,
  }) {
    _billId = billId;
    _name = name;
    _phone = phone;
    _amount = amount;
    _quantity = quantity;
    _url = url;
    _datetime = datetime;
    _address = address;
  }

  Niran.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _phone = json['phone'];
    _amount = json['amount'];
    _quantity = json['quantity'];
    _url = json['url'];
    _datetime = json['datetime'];
    _address = json['address'];
  }
  String? _billId;
  String? _name;
  String? _phone;
  String? _amount;
  String? _quantity;
  String? _url;
  String? _datetime;
  String? _address;
  Niran copyWith({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? quantity,
    String? url,
    String? datetime,
    String? address,
  }) =>
      Niran(
        billId: billId ?? _billId,
        name: name ?? _name,
        phone: phone ?? _phone,
        amount: amount ?? _amount,
        quantity: quantity ?? _quantity,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
        address: address ?? _address,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get quantity => _quantity;
  String? get url => _url;
  String? get datetime => _datetime;
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['quantity'] = _quantity;
    map['url'] = _url;
    map['datetime'] = _datetime;
    map['address'] = _address;
    return map;
  }
}

/// bill_id : "1"
/// name : "????"
/// phone : "8952136748"
/// amount : "1000"
/// address : "Rajkot"
/// type : "Yes"
/// type1 : "Yes"
/// type2 : "No"
/// cash : "No"
/// cheque_number : "123456789"
/// cheque_date : "12/12/2023"
/// bank : "SBI BANK"
/// branch : "Mavdi Main Road"
/// account_number : "123456789"
/// pan_number : "123456789"
/// url : "https://digitalpostmaker.in/RadheKrishnaCharitableTrust/AdminPanel/Receipt/1.pdf"
/// datetime : "2023-06-06 07:21:41"

Receipt receiptFromJson(String str) => Receipt.fromJson(json.decode(str));
String receiptToJson(Receipt data) => json.encode(data.toJson());

class Receipt {
  Receipt({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? address,
    String? type,
    String? type1,
    String? type2,
    String? cash,
    String? chequeNumber,
    String? chequeDate,
    String? bank,
    String? branch,
    String? accountNumber,
    String? panNumber,
    String? url,
    String? datetime,
  }) {
    _billId = billId;
    _name = name;
    _phone = phone;
    _amount = amount;
    _address = address;
    _type = type;
    _type1 = type1;
    _type2 = type2;
    _cash = cash;
    _chequeNumber = chequeNumber;
    _chequeDate = chequeDate;
    _bank = bank;
    _branch = branch;
    _accountNumber = accountNumber;
    _panNumber = panNumber;
    _url = url;
    _datetime = datetime;
  }

  Receipt.fromJson(dynamic json) {
    _billId = json['bill_id'];
    _name = json['name'];
    _phone = json['phone'];
    _amount = json['amount'];
    _address = json['address'];
    _type = json['type'];
    _type1 = json['type1'];
    _type2 = json['type2'];
    _cash = json['cash'];
    _chequeNumber = json['cheque_number'];
    _chequeDate = json['cheque_date'];
    _bank = json['bank'];
    _branch = json['branch'];
    _accountNumber = json['account_number'];
    _panNumber = json['pan_number'];
    _url = json['url'];
    _datetime = json['datetime'];
  }
  String? _billId;
  String? _name;
  String? _phone;
  String? _amount;
  String? _address;
  String? _type;
  String? _type1;
  String? _type2;
  String? _cash;
  String? _chequeNumber;
  String? _chequeDate;
  String? _bank;
  String? _branch;
  String? _accountNumber;
  String? _panNumber;
  String? _url;
  String? _datetime;
  Receipt copyWith({
    String? billId,
    String? name,
    String? phone,
    String? amount,
    String? address,
    String? type,
    String? type1,
    String? type2,
    String? cash,
    String? chequeNumber,
    String? chequeDate,
    String? bank,
    String? branch,
    String? accountNumber,
    String? panNumber,
    String? url,
    String? datetime,
  }) =>
      Receipt(
        billId: billId ?? _billId,
        name: name ?? _name,
        phone: phone ?? _phone,
        amount: amount ?? _amount,
        address: address ?? _address,
        type: type ?? _type,
        type1: type1 ?? _type1,
        type2: type2 ?? _type2,
        cash: cash ?? _cash,
        chequeNumber: chequeNumber ?? _chequeNumber,
        chequeDate: chequeDate ?? _chequeDate,
        bank: bank ?? _bank,
        branch: branch ?? _branch,
        accountNumber: accountNumber ?? _accountNumber,
        panNumber: panNumber ?? _panNumber,
        url: url ?? _url,
        datetime: datetime ?? _datetime,
      );
  String? get billId => _billId;
  String? get name => _name;
  String? get phone => _phone;
  String? get amount => _amount;
  String? get address => _address;
  String? get type => _type;
  String? get type1 => _type1;
  String? get type2 => _type2;
  String? get cash => _cash;
  String? get chequeNumber => _chequeNumber;
  String? get chequeDate => _chequeDate;
  String? get bank => _bank;
  String? get branch => _branch;
  String? get accountNumber => _accountNumber;
  String? get panNumber => _panNumber;
  String? get url => _url;
  String? get datetime => _datetime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = _billId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['amount'] = _amount;
    map['address'] = _address;
    map['type'] = _type;
    map['type1'] = _type1;
    map['type2'] = _type2;
    map['cash'] = _cash;
    map['cheque_number'] = _chequeNumber;
    map['cheque_date'] = _chequeDate;
    map['bank'] = _bank;
    map['branch'] = _branch;
    map['account_number'] = _accountNumber;
    map['pan_number'] = _panNumber;
    map['url'] = _url;
    map['datetime'] = _datetime;
    return map;
  }
}
