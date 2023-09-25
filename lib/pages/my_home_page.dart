import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:imcapp/pages/configuracao_page.dart';
import 'package:imcapp/pages/controle_peso_page.dart';
import 'package:imcapp/pages/imc_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController tabController;
   @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body:  TabBarView(
        controller: tabController,
        children: const [
          ImcPage(),
          ControlePesoPage(),
          ConfiguracaoPage(),
        ],
      ),bottomNavigationBar: ConvexAppBar.badge(
        const {},// with TickerProviderStateMixin
        items: const [
          TabItem(icon: Icons.balance, title: 'IMC'),
          TabItem(icon: Icons.graphic_eq, title: 'Peso'),
          TabItem(icon: Icons.miscellaneous_services, title: 'Configuração'),
          
        ],
        onTap: (int i) => tabController.index = i,
        controller: tabController,
      ),
        
      ),
    );
  }
}
