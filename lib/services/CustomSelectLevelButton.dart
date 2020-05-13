import 'package:flutter/material.dart';

class CustomSelecetLevelButton extends StatelessWidget{

  GestureTapCallback onTap;
  IconData iconData;
  int donutCount;

  CustomSelecetLevelButton({this.iconData, this.onTap, this.donutCount});

  List<Widget> getDonuts(){
    List<Widget> listOfDonuts=[];
    //print('In widget. donuts: $donutCount');
    for(int i=0;i<donutCount;i++){
      listOfDonuts.add(
        Image.asset('assets/donut.png', width: 25, height: 25,)
      );
    }
    if(listOfDonuts.length==0)
      listOfDonuts.add(Container(width: 25,height: 25,));
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