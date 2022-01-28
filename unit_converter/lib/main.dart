import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:"Conversor de medidas",
      home:MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState(){
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _username = "";

  @override
  void initState(){
    _username = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text("Conversor de medidas"),
        ),
        body: Center(
          child: Column(children: [
            TextField(
              onChanged: (text){
                var conversion = text.toUpperCase();
                setState((){
                  _username = conversion;
                });
              },
            ),
            Text(_username)
          ],)
        ),  
      );
  }
}
