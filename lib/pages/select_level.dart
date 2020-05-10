import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lang_guide/services/CustomSelectLevelButton.dart';
import 'package:lang_guide/services/database.dart';


class SelectLevel extends StatefulWidget {
  @override
  _SelectLevelState createState() => _SelectLevelState();
}

class _SelectLevelState extends State<SelectLevel> {

  String levelType;
  String levelDifficult;
  String titleText;
  int    taskIndex = 0;
  Color iconsColor = Colors.white;
  Map data;
  List<Map<dynamic,dynamic>> listOfTasks;


  void initEasy(int levelIndex) async{
    switch(levelType){
      case 'text':
        listOfTasks = await Database.getEasyTextTasks(levelIndex);
        break;
      case 'picture':
        break;
      case 'media':
        break;
    }
  }
  void initMedium(){
    switch(levelType){
      case 'text':
        break;
      case 'picture':
        break;
      case 'media':
        break;
    }
  }
  void initHard(){
    switch(levelType){
      case 'text':
        break;
      case 'picture':
        break;
      case 'media':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    data= ModalRoute.of(context).settings.arguments;
    levelType = data['levelType'];
    levelDifficult = data['levelDifficult'];
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
                CustomSelecetLevelButton(iconData: MdiIcons.numeric1,onTap:() async{
                  await initEasy(1);
                  Navigator.pushNamed(context, '/${levelType}Level',arguments: {
                    '0' : listOfTasks[0],
                    '1' : listOfTasks[1],
                    '2' : listOfTasks[2],
                    '3' : listOfTasks[3]
                  });
                }),
                Flexible(
                  child: FractionallySizedBox(widthFactor: 0.4,),
                ),

                CustomSelecetLevelButton(iconData: MdiIcons.numeric2,onTap:()async{
                  await initEasy(2);
                  Navigator.pushNamed(context, '/${levelType}Level',arguments: {
                    '0' : listOfTasks[0],
                    '1' : listOfTasks[1],
                    '2' : listOfTasks[2],
                    '3' : listOfTasks[3]
                  });
                }),
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
