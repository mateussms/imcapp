import 'package:flutter/material.dart';
import 'package:imcapp/model/controle_peso_model.dart';
import 'package:imcapp/model/pessoa_model.dart';
import 'package:imcapp/repository/configuracao_repository.dart';
import 'package:imcapp/repository/controle_peso_repository.dart';
import 'package:uuid/uuid.dart';

class ControlePesoPage extends StatefulWidget {
  const ControlePesoPage({super.key});

  @override
  State<ControlePesoPage> createState() => _ControlePesoPageState();
}

class _ControlePesoPageState extends State<ControlePesoPage> {
  
  final TextEditingController classificacaoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  late ControlePesoRepository controlePesoRepository;
  late ConfiguracaoRepository configuracaoRepository;
  List<ControlePesoModel> controlePesoModel = [];

  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    carregaDados();
  }

  carregaDados() async{
    controlePesoRepository  = await ControlePesoRepository.carregar();
    configuracaoRepository  = await ConfiguracaoRepository.carregar();
    
    controlePesoModel     = controlePesoRepository.obterDados();
    nomeController.text   = configuracaoRepository.obterDados().nome;
    alturaController.text = configuracaoRepository.obterDados().altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //drawer: const CustomDrawer(),
        floatingActionButton: FloatingActionButton(onPressed: (){
          showModalBottomSheet<void>(context: context, builder: (_){
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [ Expanded(
                  child: Column(children: [
                    
                    TextField(
                        controller: nomeController,
                        decoration: const InputDecoration(
                          labelText: "Nome",
                          icon: Icon(Icons.people)
                        ),
                        keyboardType: TextInputType.text,
                        readOnly: true,               
                    ),
                    
                    TextField(
                            controller: alturaController,
                            decoration: const InputDecoration(
                              labelText: "Altura",
                              icon: Icon(Icons.height)
                            ),
                            keyboardType: TextInputType.number,
                        readOnly: true,                  
                    ),
                    TextField(
                            controller: pesoController,
                            decoration: const InputDecoration(
                              labelText: "Peso",
                              icon: Icon(Icons.balance)
                            ),
                            keyboardType: TextInputType.number                  
                    ),
                    TextButton(
                      onPressed: () async{
                        if(nomeController.text.trim().isEmpty){
                          showDialog(
                            context: context, 
                            builder: (_){
                            return AlertDialog(
                                    title: const Text('Alerta'),
                                    content: const Text('Configure o nome de usuário nas configurações.'),
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
                        if(alturaController.text.trim().isEmpty){
                          showDialog(
                            context: context, 
                            builder: (_){
                            return AlertDialog(
                                    title: const Text('Alerta'),
                                    content: const Text('Configure a altura do usuário nas configurações.'),
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
                          if(pesoController.text.trim().isEmpty){
                          showDialog(
                            context: context, 
                            builder: (_){
                            return AlertDialog(
                                    title: const Text('Alerta'),
                                    content: const Text('Preencha o campo peso'),
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
                        await controlePesoRepository.salvar(ControlePesoModel(_uuid.v4.hashCode.toString(), nomeController.text,double.parse(alturaController.text),double.parse(pesoController.text),DateTime.now()));
                        pesoController.text   = "";
                        controlePesoModel     = controlePesoRepository.obterDados();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        setState(() {});
                      }, 
                      child: const Text("Salvar")
                    
                    ),
              
                ],),
                )
              ]),
            );
          });
        },
        tooltip: "Adicionar IMC", 
        child: const Icon(Icons.add),
        ),
        body: Column(
            children: [
            (controlePesoModel.isEmpty) ?
              const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Sem registros para serem listados",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
            :
              Expanded(
                child: ListView.builder(
                        itemCount: controlePesoModel.length,
                        itemBuilder: (_, int index){
                          return 
                              Dismissible(
                                key: Key(UniqueKey().toString()),
                                 background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onDismissed: (direction) async {
                                  await controlePesoRepository.delete(index);
                                  controlePesoModel = controlePesoRepository.obterDados();
                                  setState(() {});
                                },
                                child: Card(
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[ Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage("https://assets.stickpng.com/images/585e4bcdcb11b227491c3396.png"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Column( 
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                              
                                                Text(
                                                  "${controlePesoModel[index].nome} - ${controlePesoModel[index].peso}",
                                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                                ),
                                                Text(
                                                  PessoaModel(nome: controlePesoModel[index].nome, peso: controlePesoModel[index].peso, altura: controlePesoModel[index].altura,).retornaClassificacao(),
                                                  style: const TextStyle(fontSize: 12)),
                                                Text("Data: ${controlePesoModel[index].data}"
                                                  ,
                                                  style: const TextStyle(fontSize: 12)),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                      ]
                                    ),
                                  ),
                                ),
                              );
                        
                        },
                      ),
              ),
          ],
        ),
              
      ),
    );
  }
}