import 'package:flutter/material.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';

class PanicButton extends StatelessWidget{

  final String helptext;
  bool health=true;
  Color backgroundColor=Colors.white;
  PanicButton({this.helptext,this.health,this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8, top: 8),
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: [BoxShadow(color: Colors.grey,
         blurRadius: 15.0, 
            spreadRadius: 1.0,
        )]
      ),
      child: Center(
        child:Column(
          children: <Widget>[
          (health)?Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(HumanitarianIcons.emergency_telecom,
            color: Colors.red,
            size: 70,),
          ):
          Icon(HumanitarianIcons.group,
          color: Colors.blue,
          size:100), 
          Text(helptext,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25
          ),
          )
          
          ]
      ),
      )
    );
  }
}