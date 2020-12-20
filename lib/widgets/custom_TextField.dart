import 'package:flutter/material.dart';
import 'package:store/Constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;
  final onClick;



  CustomTextField(
      {Key key, this.controller, this.data, this.hintText,this.isObsecure,this.onClick}
      ) : super(key: key);



  @override
  Widget build(BuildContext context)
  {
    return Container
      (
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Theme.of(context).primaryColor,
          ),
          fillColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}