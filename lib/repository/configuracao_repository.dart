import 'package:hive/hive.dart';
import 'package:imcapp/model/configuracao_model.dart';


class ConfiguracaoRepository {
  static late Box _box;

  ConfiguracaoRepository._criar();

  static Future<ConfiguracaoRepository> carregar() async {
    if (Hive.isBoxOpen('configuracoes')) {
      _box = Hive.box('configuracoes');
    } else {
      _box = await Hive.openBox('configuracoes');
    }
    return ConfiguracaoRepository._criar();
  }

  void salvar(ConfiguracaoModel configuracoesModel) {
    _box.put('configuracaoModel', {
      'nomeUsuario': configuracoesModel.nome,
      'altura': configuracoesModel.altura
    });
  }

  ConfiguracaoModel obterDados() {
    var configuracoes = _box.get('configuracaoModel');
    if (configuracoes == null) {
      return ConfiguracaoModel.vazio();
    }
    return ConfiguracaoModel(
        configuracoes["nomeUsuario"],
        configuracoes["altura"]
        );
  }
}