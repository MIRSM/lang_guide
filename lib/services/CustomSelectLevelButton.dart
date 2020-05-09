import 'package:flutter/material.dart';

class CustomSelecetLevelButton extends StatelessWidget{

  GestureTapCallback onTap;
  IconData iconData;

  CustomSelecetLevelButton({this.iconData, this.onTap});

  @override
  Widget build(BuildContext context){
    return ClipOval(
      child: Material(
        color: Colors.lightBlue, // button color
        child: InkWell(
          splashColor: Colors.purple, // inkwell color
          child: SizedBox(width: 90, height: 90, child: Icon(iconData,size: 90,)),
          onTap: onTap,
        ),
      ),
    );
  }
}