import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget{
  const CustomDrawer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        children: [
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.weightHanging,
                      color: Colors.blue,
                      size: 24,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("IMC"),
                  ],
                )),
            onTap: (){
              
            }
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
  
  
}