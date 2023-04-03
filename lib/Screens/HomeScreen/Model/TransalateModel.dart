/// ok : true
/// text : "What"
/// from : "auto"
/// to : "gu"
/// response : "શું"

class TransalateModel {
  TransalateModel({
      bool? ok, 
      String? text, 
      String? from, 
      String? to, 
      String? response,}){
    _ok = ok;
    _text = text;
    _from = from;
    _to = to;
    _response = response;
}

  TransalateModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _text = json['text'];
    _from = json['from'];
    _to = json['to'];
    _response = json['response'];
  }
  bool? _ok;
  String? _text;
  String? _from;
  String? _to;
  String? _response;
TransalateModel copyWith({  bool? ok,
  String? text,
  String? from,
  String? to,
  String? response,
}) => TransalateModel(  ok: ok ?? _ok,
  text: text ?? _text,
  from: from ?? _from,
  to: to ?? _to,
  response: response ?? _response,
);
  bool? get ok => _ok;
  String? get text => _text;
  String? get from => _from;
  String? get to => _to;
  String? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = _ok;
    map['text'] = _text;
    map['from'] = _from;
    map['to'] = _to;
    map['response'] = _response;
    return map;
  }

}