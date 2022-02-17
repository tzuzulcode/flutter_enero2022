import 'package:flutter/material.dart';
import 'dart:math';
import 'ball.dart';
import 'bat.dart';

enum Direction{up,down,left,right}

class Pong extends StatefulWidget {
  const Pong({ Key? key }) : super(key: key);

  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin{
  late double width;
  late double height;
  int score = 0;
  double increment = 10;
  double posx=1;
  double posy=1;
  double randx = 0;
  double randy= 0;
  double batWidth= 0;
  double batHeight = 0;
  double batPosition = 0;

  late Animation animation;
  late AnimationController controller;

  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  @override
  void initState() {
    posx = 0;
    posy=0;
    width = 0;
    height= 0;
    controller = AnimationController(duration:const Duration(seconds: 100),vsync: this);
    animation = Tween(begin: 0,end:100).animate(controller);
    animation.addListener(() {

      safeSetState((){
          vDir== Direction.down ? posy+=((increment*randy).round()): posy-=((increment*randy).round());
          hDir== Direction.right? posx+=((increment*randx).round()): posx-=((increment*randx).round());
      });
      checkBorders();
    });
    controller.forward();// Iniciar animación
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context,BoxConstraints constraints){
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      batWidth = width / 5;
      batHeight = height / 25;
      return Stack(children:[
        Positioned(
          child: Text("Score:"+score.toString()),
          top: 10,
          right: 10,
          ),
        Positioned(
          child: Ball(),
          top: posy,
          left:posx,
          ),
        Positioned(
          child: GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails update)=>moveBat(update),
            child: Bat(null,batWidth,batHeight),
          ),
          left: batPosition,
          bottom: 0,
          )
      ],);
    });
  }

  void moveBat(DragUpdateDetails update){
    safeSetState(() {
      batPosition += update.delta.dx;
    });
  }

  void checkBorders(){
    double diameter = 50;
    if(posx<=0 && hDir==Direction.left){
      hDir = Direction.right;
      randx = randomNumber();
    }
    if(posx>=width-diameter && hDir==Direction.right){
      hDir = Direction.left;
      randx = randomNumber();
    }
    if(posy<=0 && vDir==Direction.up){
      vDir = Direction.down;
      randy = randomNumber();
    }
    if(posy>=height-diameter -batHeight && vDir==Direction.down){
      if(posx>=(batPosition-diameter-25) && posx<=(batPosition+batPosition+diameter+25)){
        vDir = Direction.up;
        randx = randomNumber();
        safeSetState((){
          score++;
        });
      }else{
        controller.stop();
        showMessage(context);
      }
    }
  }

  void showMessage(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Wold you like to play again?"),
          actions: [
            TextButton(
              onPressed: (){
                setState(() {
                  posx =0;
                  posy=0;
                  score=0;
                });
                Navigator.of(context).pop();
                controller.repeat();
              }, 
              child: Text("Yes")
              ),
              TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                dispose();
              }, 
              child: Text("No")
              )
          ],
        );
      });
  }

  double randomNumber(){
    var ran = new Random();
    double myNum = ran.nextDouble();

    return myNum+0.5;
  }

  void safeSetState(Function function){
    if(mounted && controller.isAnimating){
      setState(() {
        function();
      });
    }
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}