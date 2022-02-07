import 'package:cronometer/TimerModel.dart';
import 'package:cronometer/settings.dart';
import 'package:cronometer/widgets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';

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
      home: TimerHomePage(title: 'Mi temporizador'),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  TimerHomePage({ Key? key, required this.title }) : super(key: key);
  final double defaultPadding = 5.0;
  final String title;

  final CountDownTimer timer = CountDownTimer();

  void goToSettings(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {

    timer.startWork();

    final List<PopupMenuItem<String>> menuItems = [];

    menuItems.add(const PopupMenuItem(child: Text("Settings"),value: "Settings",));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context){
              return menuItems.toList();
            },
            onSelected: (s){
              if(s=="Settings"){
                goToSettings(context);
              }
            },
          )
        ],
      ),
      body:LayoutBuilder(builder:(BuildContext context,BoxConstraints constraints){
        final double availableWidth = constraints.maxWidth;
        return Column(children: [
          Row(children: [
            Padding(padding: EdgeInsets.all(defaultPadding)),
            Expanded(
              child: ProductivityButton(color: const Color(0xff009688), 
              text: "Work", 
              onPressed: timer.startWork
            )),
            Padding(padding: EdgeInsets.all(defaultPadding)),
            Expanded(
              child: ProductivityButton(color: const Color(0xff607D8B), 
              text: "Short break", 
              onPressed: ()=>timer.startBreak(true)
            )),
            Padding(padding: EdgeInsets.all(defaultPadding)),
            Expanded(
              child: ProductivityButton(color: const Color(0xff455A64), 
              text: "Long break", 
              onPressed: ()=>timer.startBreak(false)
            )),
            Padding(padding: EdgeInsets.all(defaultPadding)),
          ],
          ),
          Expanded(
            child: StreamBuilder(
              initialData: '00:00',
              stream: timer.stream(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                TimerModel timer = (snapshot.data=='00:00')?TimerModel('00:00',1):snapshot.data;
                  return CircularPercentIndicator(
                    radius: availableWidth/4,
                    lineWidth: 10,
                    percent: timer.percent,
                    progressColor: const Color(0xff009688),
                    center: Text(timer.time,style: Theme.of(context).textTheme.headline3),

                  );
              },
            )
          ),
          Row(children: [
            Padding(padding: EdgeInsets.all(defaultPadding)),
            Expanded(child: ProductivityButton(color: const Color(0xff212121), text: "Stop", onPressed: timer.stopTimer)),
            Padding(padding: EdgeInsets.all(defaultPadding)),
            Expanded(child: ProductivityButton(color: const Color(0xff009688), text: "Start", onPressed: timer.startTimer)),
            Padding(padding: EdgeInsets.all(defaultPadding)),
          ])
        ],);
      }),
    ); 
  }
}
