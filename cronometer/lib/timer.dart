import 'dart:async';
import 'package:cronometer/TimerModel.dart';
import 'package:cronometer/settings.dart';
import 'package:flutter/material.dart';

class CountDownTimer{
  double _radius = 1;
  bool _isActive = false;
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;
  late Timer timer;
  late Duration _time;
  late Duration _fulltime;


  Stream<TimerModel> stream() async*{
    yield* Stream.periodic(const Duration(seconds: 1),(int a){
      String time;
      if(_isActive){
        _time = _time - const Duration(seconds: 1);
        _radius = _time.inSeconds/_fulltime.inSeconds;
        if(_time.inSeconds<=0){
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time,_radius);
    });
  }

  void stopTimer(){
    _isActive = false;
  }
  void startTimer(){
    if(_time.inSeconds>0){
      _isActive = true;
    }
  }

  void startWork(){
    _radius = 1;
    _time = Duration(minutes: work,seconds: 0);
    _fulltime = _time;
  }
  void startBreak(bool isShort){
    _radius = 1;
    _time = Duration(
      minutes: isShort ? shortBreak : longBreak,
      seconds: 0
      );
    _fulltime = _time;
  }

  String returnTime(Duration t){
    String minutes = (t.inMinutes<10)?'0'+t.inMinutes.toString():
    t.inMinutes.toString();

    int numSeconds = t.inSeconds -(t.inMinutes*60);
    String seconds = (numSeconds<10)?'0'+numSeconds.toString():
    numSeconds.toString();

    String formattedTime = minutes + ":" +seconds;
    return formattedTime;
  }
}