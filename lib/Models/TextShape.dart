import 'package:flutter/material.dart';

class TextShape extends StatelessWidget {
  String text;
  Color? textColor = Colors.black;
  FontWeight? fontWeight;
  double textSize;

  TextShape(this.text,this.textSize,{this.textColor,this.fontWeight});

  Widget build(BuildContext context) {
    return Text("$text",style: TextStyle(fontSize: MediaQuery.of(context).size.width * textSize,fontWeight: fontWeight,color: textColor),);
  }
}
