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
      home: Scaffold(
        appBar: AppBar(
          title:const Text("Hola mundo, desde flutter"),
          backgroundColor: Colors.deepPurple,
        ),
        body: const MyHomePage(title: "Hola mundo, desde flutter"),
      )
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
  //final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20,backgroundColor: Colors.deepPurpleAccent));

  // Agregar el contenido de la aplicación

  @override
  Widget build(BuildContext context){
    // Center: Positional Widget

    
    // const myText = Text(
    //   "Mi primer widget",
    //   style: TextStyle(color: Colors.white,fontSize: 20,backgroundColor: Colors.lime),
    //   textAlign: TextAlign.center,
    // );
    // const center = Center(child: myText);

    // return center;

    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(40), // Padding a todos los lados
            child: Column(children: [
              Text(
              "Mi primer widget",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const Text(
              "Mi segundo widget",
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurpleAccent,
              ),
            )
          ],),
          ),
          Image.network("https://images.unsplash.com/photo-1586227740560-8cf2732c1531?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=961&q=80"),
          ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
              onPressed: () {contactUs(context);},
              child: const Text('Aceptar'),
              
            )
        ],)
      ),
    );
  }
  void contactUs(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Contactanos..."),
        content: const Text("Envía un correo a mail@tzuzulcode.com"),
        actions: [
          TextButton(
            onPressed: ()=>Navigator.of(context).pop(), // Navega hacia atras
            child: const Text("Cerrar")
          )
        ],
      );
    });
  }

  // Edu Falcon: State
  // Daniel Vargas
  // Maximiliano Cabrera *

  //Statefull widgets: Cómo funciona el estado

  // Built-in widgets:
  // Alejandro Cortes*
  // Kevin Andres*
  // Mattias Alexandre Duarte *
  // Julio Mateus
}


// class HomePage extends StatefulWidget{
//   HomePage({Key key, required this.title}):super(key:key);

//   final String title;

//   // State companion object
//   @override
//   _HomePageState createState(){
//     return _HomePageState();
//   }
//  @override
//  _HomePageState createState() => _HomePageState();
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