import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imcapp/model/controle_peso_model.dart';

class ControlePesoRepository{
   static late Box _box;
   late List<ControlePesoModel> controlePesoModels = [];
   static List<String> data = [];

  ControlePesoRepository._criar();

  static Future<ControlePesoRepository> carregar() async {
    if (Hive.isBoxOpen('controlePeso')) {
      _box = Hive.box('controlePeso');
    } else {
      _box = await Hive.openBox('controlePeso');
    }
    _box.delete('controlePesoModel');   
    List<dynamic> configuracoes;
    
    try{
     configuracoes = json.decode(_box.get('controlePesoModel'));
    } catch(e){
      configuracoes = [];
    }

    for(int i = 0; i < configuracoes.length; i++){
      data.add(configuracoes[i]);
    }

    return ControlePesoRepository._criar();
  }

  Future<void> salvar(ControlePesoModel controlePesoModel) async {
    data.add(json.encode(controlePesoModel.toJson()));
    await _box.put('controlePesoModel', jsonEncode(data));
  }

   Future<void> delete(int index) async {
    //await _box.delete('controlePesoModel');
    data.removeAt(index);
    controlePesoModels.removeAt(index);
    await _box.put('controlePesoModel', jsonEncode(data));
    
  }

  List<ControlePesoModel> obterDados() {
    controlePesoModels = [];
    for(int i = 0; i < data.length; i++){
      controlePesoModels.add(ControlePesoModel.fromJson(json.decode(data[i])));
    }
    return controlePesoModels;
  }
  
}