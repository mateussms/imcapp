import 'package:imcapp/model/pessoa_model.dart';

class PessoaImcRepository{
  final List<PessoaModel> _pessoaModel = [];
  final String? classificacao = "";

  void add(PessoaModel pessoaModel){
    _pessoaModel.add(pessoaModel);
  }

  List<PessoaModel> getList({String? classificacao}){
    return (classificacao == null || classificacao.isEmpty) ? _pessoaModel : _pessoaModel.where((element) => element.retornaClassificacao().toLowerCase().contains(classificacao.toLowerCase())).toList();
  }

  Future<void> delete(PessoaModel pessoaModel) async {
    _pessoaModel.remove(pessoaModel);
  }

 

}