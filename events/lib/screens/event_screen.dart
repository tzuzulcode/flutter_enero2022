import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/models/event_detail.dart';
import 'package:events/models/favorite.dart';
import 'package:events/screens/login_screen.dart';
import 'package:events/shared/authentication.dart';
import 'package:events/shared/firestore_helper.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen(Key? key,this.uid) : super(key: key);

  final String uid;

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
      body: EventList(uid,key),
    );
  }
}

class EventList extends StatefulWidget {
  final String uid;


  const EventList(this.uid,Key? key): super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<EventDetail> details = [];
  List<Favorite> favorites = [];

  @override
  void initState() {
    if(mounted){
      getDetailsList()
      .then((data){
        setState(() {
          details = data;
        });
      });

      FirestoreHelper.getUserFavorites(widget.uid)
      .then((data){
        setState(() {
          favorites = data;
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
        Color starColor = isUserFavorite(details[position].id!) ? Colors.amber:Colors.grey;
        return ListTile(
          title: Text(details[position].description),
          subtitle: Text(subtitle),
          trailing: IconButton(
            icon: Icon(Icons.star,color:starColor),
            onPressed: (){toggleFavorite(details[position]);},
          ),
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

  void toggleFavorite(EventDetail ed) async{

    print(ed.id);
    if(isUserFavorite(ed.id!)){
      Favorite favorite = favorites.firstWhere((Favorite f) => f.eventId==ed.id!);

      await FirestoreHelper.deleteFavorite(favorite.id!);
    }else{
      await FirestoreHelper.addFavorite(ed, widget.uid);
    }

    List<Favorite> updatedFavorites = await FirestoreHelper.getUserFavorites(widget.uid);
    setState(() {
      favorites = updatedFavorites;
    });
  }


  bool isUserFavorite(String eventId){
    for (var favorite in favorites) {
      if(favorite.eventId==eventId){
        return true;
      }
    }
    return false;
  }
}