import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/models/event_detail.dart';
import 'package:events/screens/login_screen.dart';
import 'package:events/shared/authentication.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Authentication auth = new Authentication();
    return Scaffold(
      appBar: AppBar(
        title: Text("Event"),
        actions: [
          IconButton(
            onPressed: (){
              auth.signOut()
              .then((result){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            }, 
            icon: const Icon(Icons.exit_to_app)
          )
        ],
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
  void initState() {
    if(mounted){
      getDetailsList()
      .then((data){
        setState(() {
          details = data;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: details.length,
      itemBuilder: (context,position){
        String subtitle = "Date: ${details[position].date} - Start: ${details[position].startTime} - End: ${details[position].endTime}";
        return ListTile(
          title: Text(details[position].description),
          subtitle: Text(subtitle),
        );
      },
    );
  }

  Future getDetailsList() async{
    var data = await db.collection("events").get();
    details = data.docs.map((doc){
      var eventDetail = EventDetail.fromMap(doc.data());
      eventDetail.id = doc.id;
      return eventDetail;
    }).toList();

    return details;
  }
}