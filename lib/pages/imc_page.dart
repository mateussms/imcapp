import 'package:flutter/material.dart';
import 'package:imcapp/model/pessoa_model.dart';
import 'package:imcapp/repository/pessoa_imc_repository.dart';
import 'package:uuid/uuid.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final PessoaImcRepository _pessoaImcRepository = PessoaImcRepository();
  final TextEditingController classificacaoController = TextEditingController();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();


  String _classificacao = "";

  @override
  void initState() {
    super.initState();
    carregaDados();
  }

  carregaDados(){

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
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
                        keyboardType: TextInputType.text                  
                    ),
                    TextField(
                            controller: pesoController,
                            decoration: const InputDecoration(
                              labelText: "Peso",
                              icon: Icon(Icons.balance)
                            ),
                            keyboardType: TextInputType.number                  
                    ),
                    TextField(
                            controller: alturaController,
                            decoration: const InputDecoration(
                              labelText: "Altura",
                              icon: Icon(Icons.height)
                            ),
                            keyboardType: TextInputType.number                  
                    ),
                    TextButton(
                      onPressed: (){
                        if(nomeController.text .trim().isEmpty){
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
                         if(pesoController.text .trim().isEmpty){
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
                        if(alturaController.text .trim().isEmpty){
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
                        _pessoaImcRepository.add(PessoaModel(nome: nomeController.text, peso: double.tryParse(pesoController.text)??0, altura: double.tryParse(alturaController.text) ?? 0));
                        nomeController.text   = "";
                        pesoController.text   = "";
                        alturaController.text = "";
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
        appBar: AppBar(
          title: const Text("IMC", style: TextStyle(color: Colors.white),),
          backgroundColor: const Color.fromARGB(255, 17, 0, 167),
          
        ),
        body: Column(
            children: [
            TextField(
                    controller: classificacaoController,
                    decoration: const InputDecoration(
                      labelText: "Ex.: Saudável",
                      icon: Icon(Icons.search)
                    ),
                    onChanged: (value) {
                      _classificacao = value;
                      setState(() {});
                    },
                    keyboardType: TextInputType.text                  
            ),
            _pessoaImcRepository.getList(classificacao:_classificacao).isEmpty ?
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
                        itemCount: _pessoaImcRepository.getList(classificacao:_classificacao).length,
                        itemBuilder: (_, int index){
                          return 
                              Dismissible(
                                key: Key(const Uuid().v4.toString()),
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
                                  await _pessoaImcRepository.delete(_pessoaImcRepository.getList(classificacao:_classificacao)[index]);
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
                                                  _pessoaImcRepository.getList(classificacao:_classificacao)[index].nome,
                                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                                ),
                                                Text(
                                                  _pessoaImcRepository.getList(classificacao:_classificacao)[index].retornaClassificacao(),
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