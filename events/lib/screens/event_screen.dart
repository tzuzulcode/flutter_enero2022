import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/models/event_detail.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event"),
      ),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  const EventList({ Key? key }) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<EventDetail> details = [];


  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }

  Future getDetailsList() async{
    var data = await db.collection("events").get();
    details = data.docs.map((doc){
      var eventDetail = EventDetail.fromMap(doc);
      eventDetail.id = doc.id;
      return eventDetail;
    }).toList();
  }
}