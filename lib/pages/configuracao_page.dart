import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imcapp/model/configuracao_model.dart';
import 'package:imcapp/repository/configuracao_repository.dart';

class ConfiguracaoPage extends StatefulWidget {
  const ConfiguracaoPage({super.key});

  @override
  State<ConfiguracaoPage> createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  late ConfiguracaoRepository configuracaoRepository;
  var configuracaoModel = ConfiguracaoModel.vazio();

  @override
  void initState() {
    super.initState();
    carregaDados();
  }

  carregaDados() async{
   configuracaoRepository = await ConfiguracaoRepository.carregar();
    configuracaoModel = configuracaoRepository.obterDados();
    _nomeController.text = configuracaoModel.nome;
    _alturaController.text = configuracaoModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          labelText: "Nome",
                          icon: FaIcon(FontAwesomeIcons.user)
                        ),
                        keyboardType: TextInputType.text                  
                ),
                TextField(
                        controller: _alturaController,
                        decoration: const InputDecoration(
                          labelText: "Altura",
                          icon: FaIcon(FontAwesomeIcons.rulerVertical)
                        ),
                        keyboardType: TextInputType.number                  
                ),
                TextButton(
                      onPressed: () async{
                        if(_nomeController.text .trim().isEmpty){
                          showDialog(
                            context: context, 
                            builder: (_){
                            return AlertDialog(
                                    title: const Text('Alerta'),
                                    content: const Text('Preencha o campo nome'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Fecha o alerta
                                        },
                                        child: const Text('Fechar'),
                                      ),
                                    ],
                                  );
                          });
                          return;
                        }
                        if(_alturaController.text .trim().isEmpty){
                          showDialog(
                            context: context, 
                            builder: (_){
                            return AlertDialog(
                                    title: const Text('Alerta'),
                                    content: const Text('Preencha o campo altura'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Fecha o alerta
                                        },
                                        child: const Text('Fechar'),
                                      ),
                                    ],
                                  );
                          });
                          return;
                        }
                        configuracaoModel.nome = _nomeController.text;
                        configuracaoModel.altura = double.tryParse(_alturaController.text) ?? 0;
                        configuracaoRepository.salvar(configuracaoModel);
                        setState(() {});
                        
                      }, 
                      child: const Center(
                        child: Text("Salvar") ,
                      )
                    
                    ),
                   
              ],
            ),
        ),
      ),
    );
  }
}