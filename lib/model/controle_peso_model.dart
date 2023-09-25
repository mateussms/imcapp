import 'package:uuid/uuid.dart';

class ControlePesoModel {
  String _id = "";
  double _peso = 0;
  DateTime? _data;
  String _nome = "";
  double _altura = 0;

  ControlePesoModel.vazio() {
     _nome = "";
    _altura = 0;
    _data = null;
    _peso = 0;
  }

  ControlePesoModel(this._id,this._nome, this._altura, this._peso, this._data);

 String get id => _id;

 set id(String id){
  _id = id;
 }

 String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }


  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }
  

  DateTime? get data => _data;
  set data(DateTime? data) {
    _data = data;
  }

  double get peso => _peso;
  set peso(double peso) {
    _peso = peso;
  }

  ControlePesoModel.fromJson(Map<String, dynamic> json)
      : _id = json["id"] ?? "",
        _nome = json['nome'] ?? "",
        _altura = double.parse(json['altura']) ?? 0,
        _data = DateTime.parse(json['data']) ?? DateTime.now(),
        _peso = double.parse(json['peso']) ?? 0;

  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "nome": _nome,
      "altura": _altura.toString(),
      "data": _data.toString(),
      "peso": _peso.toString(),
    };
  }
}