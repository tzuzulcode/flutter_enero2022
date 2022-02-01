import 'package:cronometer/widgets.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const TimerHomePage(title: 'Mi temporizador'),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  const TimerHomePage({ Key? key, required this.title }) : super(key: key);
  final double defaultPadding = 5.0;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Column(children: [
        Row(children: [
          Padding(padding: EdgeInsets.all(defaultPadding)),
          Expanded(child: ProductivityButton(color: const Color(0xff009688), text: "Work", onPressed: prueba)),
          Padding(padding: EdgeInsets.all(defaultPadding)),
          Expanded(child: ProductivityButton(color: const Color(0xff607D8B), text: "Short break", onPressed: prueba)),
          Padding(padding: EdgeInsets.all(defaultPadding)),
          Expanded(child: ProductivityButton(color: const Color(0xff455A64), text: "Long break", onPressed: prueba)),
        ],
        ),
        Expanded(child: Text("Bienvenido"),),
        Row(children: [
          Padding(padding: EdgeInsets.all(defaultPadding)),
          Expanded(child: ProductivityButton(color: const Color(0xff212121), text: "Work", onPressed: prueba)),
          Padding(padding: EdgeInsets.all(defaultPadding)),
          Expanded(child: ProductivityButton(color: const Color(0xff009688), text: "Short break", onPressed: prueba)),
        ])
      ],)
    ); 
  }

  void prueba(){

  }
}
