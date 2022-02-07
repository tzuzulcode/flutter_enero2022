import 'package:cronometer/widgets.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),),
      body: Container(child: Settings(),),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextStyle textStyle = TextStyle(fontSize:24);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3, // Numero de columnas
        childAspectRatio: 3, // Ancho 3 veces más que la altura
        crossAxisSpacing: 10, //Espaciado entre columnas
        mainAxisSpacing: 10, // Espaciado entre filas
        children: [
          Text("Work",style:textStyle ,),
          Text(""),
          Text(""),
          const SettingsButton(null, Color(0xff455A64), "-", -1),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          const SettingsButton(null, Color(0xff455A64), "+", 1),
        ],
        padding: const EdgeInsets.all(20),
      )
    );
  }
}