class ConfiguracaoModel {
  String _nome = "";
  double _altura = 0;

  ConfiguracaoModel.vazio() {
    _nome = "";
    _altura = 0;
  }

  ConfiguracaoModel(this._nome, this._altura);

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }


  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }
 
 ConfiguracaoModel.fromJson(Map<String, dynamic> json)
      : _nome = json['nome'],
        _altura = json['altura'];

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'altura': _altura,
    };
  }

}