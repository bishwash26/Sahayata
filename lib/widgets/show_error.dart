import 'package:flutter/material.dart';
class show_eroor{
  final String messege;
  show_eroor(this.messege);
  void showerror(var contexts)
  {
    showDialog(
      context: contexts,
      builder: (ctx) => AlertDialog(
        title: Text("Error",
      ),
      content: Text("messege"),
      actions: <Widget>[
        FlatButton(
          child: Text("Okay"),
          onPressed: Navigator.of(ctx).pop,
        )
      ],

      )
    );
  }

}