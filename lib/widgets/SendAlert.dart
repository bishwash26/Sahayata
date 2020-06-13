
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:firebase_messaging/firebase_messaging.dart";
import 'package:http/http.dart'as http;
import  'dart:convert';
import 'dart:async';
import 'package:provider/provider.dart';

import 'package:path/path.dart';
import "./Counter.dart";

_SendAlertState alertState;

class SendAert extends StatefulWidget {
  final Coordinates cord;
  SendAert(this.cord);
  
  

  @override
  _SendAlertState createState() {
    alertState=_SendAlertState(cord);
    return alertState;}
}

class _SendAlertState extends State<SendAert> {
   int pcounter=0;
   bool isSent=false;
   final Coordinates cord;
   final FirebaseMessaging _messaging=FirebaseMessaging();
   final String serverToken = '*************************************************************';
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
   _SendAlertState(this.cord);
    bool sitiosToggle = false;
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; 
    Widget _child;
    GoogleMapController _controller;
    final titleController = TextEditingController();

 @override
  void initState() {
    _child=SpinKitRotatingCircle(color: Colors.amber,);
    populateClients();
    super.initState();
  }

  
Future<Map<String, dynamic>> sendAndRetrieveMessage(String des,String url,List n_tokens,context,String r_token) async {
  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  );
  print("firebase messeging invoked");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name=prefs.getString("name");
 String phone_no=prefs.getString("phone_no");


  var result=await http.post(
    'https://fcm.googleapis.com/fcm/send',
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=$serverToken',
     },
     body: jsonEncode(
     <String, dynamic>{
       'registration_ids': n_tokens,
       'notification': <String, dynamic>{
         'body': 'Nearby',
         'title': '$name needs your help.Tap to help him.'
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
         'id': '1',
         'status': 'done',
         'Description':'$des',
         'latitude':cord.latitude,
         'longitude':cord.longitude,
         'phone_number':"$phone_no",
         'name':'$name',
         "return_token":'$r_token',
       }
     },
    ),
  );
  print(result.body);
  var outcome=jsonDecode(result.body);
  if (outcome["success"]==0)
  {
    return showAlertDialog(context, "Fialed", "Sorry the sending failed.Time to stand up and fight by yourself");
  }
  else
  {
    setState(() {
      isSent=true;
    });
    int people=outcome["success"];
    return showAlertDialog(context, "Successs", "The messege has reached to $people  people.Stay strong help might be coming");
  }
  
}

showAlertDialog(BuildContext context,String title,String text) {

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () { Navigator.of(context).pop();},
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

      populateClients() {
        Firestore.instance.collection('markers').getDocuments().then((docs){
          if (docs.documents.isNotEmpty){
            for(int i=0;i<docs.documents.length;++i)
            {
              initMarker(docs.documents[i].data,docs.documents[i].documentID);
            }
          }
        });
      }

      void  initMarker(request, requestid){
        print("init marker is initiated");
        var markerIdVal=requestid;
        final MarkerId markerId=MarkerId(requestid);
        final Marker marker=Marker(markerId: markerId,
        position: LatLng(request["Location"].latitude,request["Location"].longitude),
          infoWindow: InfoWindow(title:"Fetched Markers",snippet: request["address"])
        );
        print("marker");
        setState(() {
          markers[markerId]=marker;
          print(markerId);
        });
      }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sending Alert"),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(initialCameraPosition: CameraPosition(
      target: LatLng(cord.latitude,cord.longitude),
      zoom: 15
          ),
          mapType: MapType.normal,
          markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController controller){
            _controller=controller;
          },
          myLocationEnabled: true,        
          ),
          (!isSent)?
          Container(
          child:Column(
            children: [
              Theme(
  data: Theme.of(context).copyWith(splashColor: Colors.transparent),
  child: TextField(
    maxLines: null,
    controller: titleController,
    autofocus: false,
    style: TextStyle(fontSize: 22.0, color: Colors.black),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: "Share some description",
      hintStyle: TextStyle(
        fontSize: 20,
        color:Colors.grey,
      ),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
    ),
  ),
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  //    FloatingActionButton(
  //      backgroundColor: Colors.red[600],
  //     onPressed: ()async{
  //  image = await ImagePicker.pickImage(source: ImageSource.camera);
  //     },
  //     tooltip: 'Pick an identification Image',
  //     child: Padding(
  //       padding: const EdgeInsets.all(7.0),
  //       child: Icon(Icons.add_a_photo,
  //       color: Colors.amberAccent[300],
  //       size: 35,),
  //     ),
  //   ),
    
        Container(   
          height: 50,
          width: 100,
              child:  RaisedButton(onPressed: 
                ()
                 { 
                  String d_url="";
                 List nearby_users =[];
                 String my_token;
         _messaging.getToken().then((f_token){
      my_token=f_token;
    });
                  Firestore.instance.collection('markers').getDocuments().then((docs)async{
          if (docs.documents.isNotEmpty){
            for(int i=0;i<docs.documents.length;++i)
            {  
              double distance=await new Geolocator().distanceBetween(cord.latitude, cord.longitude, docs.documents[i]["Location"].latitude, docs.documents[i]["Location"].longitude);
              print("........");
              print(cord);
              print(docs.documents[i]["Location"].latitude);
              print(docs.documents[i]["Location"].longitude);
              print(distance);
              if(docs.documents[i].data["fcm_token"]!=my_token)
              {
              if(distance<10000)
              {
        
                  nearby_users.add(docs.documents[i].data["fcm_token"]);
              }
              }           
            }
            if (nearby_users.length==0)
            {
              return showAlertDialog(context, "Apologies", "There are no active users in your vicinity. Try calling the helpline numbers");
            }
             sendAndRetrieveMessage(titleController.text,d_url,nearby_users,context,my_token);
          }});                         
                },
                shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.red)
),
                color: Colors.red[600],
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color:Colors.white
                  ),
                ),
                )
                ),             
  ],
)        
            ],
          ),
          ):
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment(1,1.5),
            child:Column(    
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center ,         
              children:[
                Container(
                  color:Colors.white,
                  child: Icon(Icons.people,
                  color: Colors.black,
                  size: 50,
                  semanticLabel: "Number of people Ariving",
                  )
                ),
                Container(
                  color: Colors.white,
                  child:Text(pcounter.toString(),
                  style: TextStyle(
                  fontSize: 28,
                  fontWeight:FontWeight.bold
                  ),
                  )  
                )  
              ]
            ),
          )
        ]
      ),
    );
  }
}
