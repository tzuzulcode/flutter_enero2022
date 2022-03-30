import '../shared/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'map.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({ Key? key }) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    super.initState();

    Authentication authentication = Authentication();
    authentication.getUser()
    .then((user){
      MaterialPageRoute route;
      if(user!=null){
        route = MaterialPageRoute(builder: (context)=>MainMap(user.uid,null));
      }else{
        route = MaterialPageRoute(builder: (context)=>LoginScreen());
      }
      
      Navigator.pushReplacement(context, route);
    }).catchError((err)=>print(err));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}