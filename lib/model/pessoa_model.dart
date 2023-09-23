class PessoaModel {
  String nome;
  double peso;
  double altura;

  PessoaModel({required this.nome, required this.peso, required this.altura});

  double retornaIMC(){
    return double.parse((peso/(altura * 2)).toStringAsFixed(2));
  }

  String retornaClassificacao(){
    switch(retornaIMC()){
      case < 16.0:             return "Magreza grave";
      case  >= 16.0 && < 17.0: return "Magreza moderada";
      case  >= 17.0 && < 18.5: return "Magreza leve";
      case  >= 18.5 && < 25.0: return "Saudável";
      case  >= 25.0 && < 30.0: return "Sobrepeso";
      case  >= 30.0 && < 35.0: return "Obesidade Grau I";
      case  >= 35.0 && < 40.0: return "Obesidade Grau II (severa)";
      case  >= 40.0:           return "Obesidade Grau III (mórbida)";
      default:                 return "Faixa não identificada";
    }
  }
}