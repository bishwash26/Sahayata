import 'package:flutter/material.dart';

class SendContacts extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sending..."),
      ),
      body: 
 Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Ink( 
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.redAccent,
                  ),
                  iconSize: 120.0,
                  splashColor: Colors.blue,
                  padding: EdgeInsets.all(40.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            Padding(
              padding: EdgeInsets.all(25.0),
            ),
            Text(
              "This page is opened to avoid any accidental further presses.Tap to go back and see the progress",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.2,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      )
    );
  }
}