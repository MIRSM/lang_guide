import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lang_guide/services/CustomSelectLevelButton.dart';

class SelectLevel extends StatefulWidget {
  @override
  _SelectLevelState createState() => _SelectLevelState();
}

class _SelectLevelState extends State<SelectLevel> {

  String levelType;
  String titleText;
  Color iconsColor = Colors.white;
  Map data;

  @override
  Widget build(BuildContext context) {
    data= ModalRoute.of(context).settings.arguments;
    levelType = data['levelType'];

    initParams();

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomSelecetLevelButton(iconData: MdiIcons.numeric1,onTap:(){}),
                Flexible(
                  child: FractionallySizedBox(widthFactor: 0.4,),
                ),

                CustomSelecetLevelButton(iconData: MdiIcons.numeric2,onTap:(){}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                CustomSelecetLevelButton(iconData: MdiIcons.numeric3,onTap:(){}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomSelecetLevelButton(iconData: MdiIcons.numeric4,onTap:(){}),
                Flexible(
                  child: FractionallySizedBox(widthFactor: 0.4,),
                ),

                CustomSelecetLevelButton(iconData: MdiIcons.numeric5,onTap:(){}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                CustomSelecetLevelButton(iconData: MdiIcons.numeric6,onTap:(){}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomSelecetLevelButton(iconData: MdiIcons.numeric7,onTap:(){}),
                Flexible(
                  child: FractionallySizedBox(widthFactor: 0.4,),
                ),

                CustomSelecetLevelButton(iconData: MdiIcons.numeric8,onTap:(){}),
              ],
            ),
          ]),
        );
  }

  void initParams(){
    switch(levelType){
      case 'text':
        titleText = 'Задания с текстом';
        break;
      case 'picture':
        titleText = 'Задания с картинками';
        break;
      case 'media':
        titleText = 'Задания с аудио/видео';
        break;
      default:
        titleText = 'Ошибка';
        break;
    }
  }
}
