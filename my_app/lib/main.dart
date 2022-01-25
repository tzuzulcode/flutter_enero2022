import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  // Revisar contexto
  @override
  Widget build(BuildContext context) {
    //MaterialApp es un widget
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Tzuzul Code App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  // Agregar el contenido de la aplicación

  @override
  Widget build(BuildContext context){
    const myText = Text(
      "Mi primer widget",
      style: TextStyle(color: Colors.lightBlue,fontSize: 20),
      textAlign: TextAlign.center,
    );

    return myText;
  }

  // Edu Falcon: State
  // Daniel Vargas
  // Maximiliano Cabrera

  //Statefull widgets: Cómo funciona el estado
}


// class HomePage extends StatefulWidget{
//   HomePage({Key key, required this.title}):super(key:key);

//   final String title;

//   // State companion object
//   @override
//   _HomePageState createState(){
//     return _HomePageState();
//   }
// }

// class _HomePageState extends State<HomePage>{
//   int _counter = 0;

//   void _increment(){
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context){

//   }

// }