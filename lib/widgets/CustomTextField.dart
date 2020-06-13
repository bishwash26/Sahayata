import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
   final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldValidator validator;
  final  controller;
  CustomTextfield(
    {
      this.onSaved,
      this.icon,
      this.hint,
      this.obsecure:false,
      this.validator,
      this.controller
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        autofocus: true,
        validator: validator,
        obscureText: obsecure,
        onSaved: onSaved,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        decoration: InputDecoration(
        hintText:hint,
        hintStyle:TextStyle(
          color:Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color:Theme.of(context).accentColor,
            width: 2
          )
        ),
        prefixIcon: Padding(
          child: icon,
          padding: const EdgeInsetsDirectional.only(start: 2.0) ,
        )
         ),  
        ),
      );
  }
}