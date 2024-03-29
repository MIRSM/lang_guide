import 'package:flutter/material.dart';

class CustomSelecetLevelButton extends StatelessWidget{

  GestureTapCallback onTap;
  IconData iconData;
  int donutCount;

  CustomSelecetLevelButton({this.iconData, this.onTap, this.donutCount});

  List<Widget> getDonuts(){
    
    List<Widget> listOfDonuts=[];
    for(int i=0;i<4;i++){
      double opacity = i<donutCount?1:0.1;
      listOfDonuts.add(
        Opacity(
            opacity: opacity,
            child: Image.asset('assets/donut.png', width: 25, height: 25,))
      );
    }
    return listOfDonuts;
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        ClipOval(
          child: Material(
            color: Colors.lightBlue, // button color
            child: InkWell(
              splashColor: Colors.purple, // inkwell color
              child: SizedBox(width: 90, height: 90, child: Icon(iconData,size: 90,)),
              onTap: onTap,
            ),
          ),
        ),
        Row(children: getDonuts(),)
      ],
    );
  }
}