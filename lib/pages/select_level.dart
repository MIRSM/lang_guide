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

  String user_id;
  String levelType;
  String levelDifficult;
  String titleText;
  String levelIndex;
  Color iconsColor = Colors.white;
  Map data;
  List<Map<dynamic,dynamic>> listOfTasks;
  List<Map<String,dynamic>> listOfDonuts;
  Map<String,dynamic> mapOfDonuts;
  Future<Map<String,dynamic>> futureMapOfDonuts;

  static const List<IconData> iconDataList=[
    MdiIcons.numeric1,
    MdiIcons.numeric2,
    MdiIcons.numeric3,
    MdiIcons.numeric4,
    MdiIcons.numeric5,
    MdiIcons.numeric6,
    MdiIcons.numeric7,
    MdiIcons.numeric8
  ];

  Future<Map<String,dynamic>> getAllDonuts()async {
    listOfDonuts=[];
    if(mapOfDonuts==null)
      mapOfDonuts = Map<String,dynamic>();
    listOfDonuts = await Database.getCompletedLevels(user_id, levelDifficult, levelType);
    for(int i=0;i<listOfDonuts.length;i++){
      mapOfDonuts['${listOfDonuts[i]['level_number']}'] =listOfDonuts[i]['points'];
    }
    //print(mapOfDonuts);
    return mapOfDonuts;
  }

  int getDonutsOfLevel(int level){
    if(mapOfDonuts['$level']!=null){
      print('level: $level, donuts: ${int.parse(mapOfDonuts['$level'])}');
      return int.parse(mapOfDonuts['$level']);
    }
    return 0;
  }

  void initDifficult(int index) async{
    switch(levelDifficult){
      case 'Начинающий':
        return await initEasy(index);
      case 'Средний':
        return initMedium(index);
      case 'Продвинутый':
        return initHard(index);
    }
  }

  void initEasy(int index) async{
    levelIndex = index.toString();
    switch(levelType){
      case 'text':
        listOfTasks = await Database.getEasyTextTasks(index);
        break;
      case 'image':
        listOfTasks = await Database.getEasyImageTasks(index);
        break;
      case 'media':
        break;
    }
  }
  void initMedium(int index){
    switch(levelType){
      case 'text':
        break;
      case 'image':
        break;
      case 'media':
        break;
    }
  }
  void initHard(int index){
    switch(levelType){
      case 'text':
        break;
      case 'image':
        break;
      case 'media':
        break;
    }
  }

  List<Widget> initButtons(){
    List<Widget> listOfButtons=[];
    listOfButtons.add(SizedBox(height: 25,),);
    bool odd = false;
    for(int i=0;i<8;i++){
      if(odd){
        listOfButtons.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomSelecetLevelButton(donutCount: getDonutsOfLevel(i+1),iconData: iconDataList[i],onTap:()async{
              await initDifficult(i+1);
              await Navigator.pushNamed(context, '/${levelType}Level',arguments: {
                'user_id' : user_id,
                'difficult' : levelDifficult,
                'level_number' : levelIndex,
                '0' : listOfTasks[0],
                '1' : listOfTasks[1],
                '2' : listOfTasks[2],
                '3' : listOfTasks[3]
              });
              setState(() {
                levelType = data['levelType'];
              });
            }),
          ],),
        );
      }else{
        listOfButtons.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomSelecetLevelButton(donutCount: getDonutsOfLevel(i+1), iconData: iconDataList[i++],onTap:() async{
              await initDifficult(i);
               await Navigator.pushNamed(context, '/${levelType}Level',arguments: {
                'user_id' : user_id,
                'difficult' : levelDifficult,
                'level_number' : levelIndex,
                '0' : listOfTasks[0],
                '1' : listOfTasks[1],
                '2' : listOfTasks[2],
                '3' : listOfTasks[3]
              });
               setState(() {
                 levelType = data['levelType'];
               });
            }),
            Flexible(
              child: FractionallySizedBox(widthFactor: 0.4,),
            ),
            CustomSelecetLevelButton(donutCount: getDonutsOfLevel(i+1), iconData: iconDataList[i],onTap:()async{
              await initDifficult(i+1);
              await Navigator.pushNamed(context, '/${levelType}Level',arguments: {
                'user_id' : user_id,
                'difficult' : levelDifficult,
                'level_number' : levelIndex,
                '0' : listOfTasks[0],
                '1' : listOfTasks[1],
                '2' : listOfTasks[2],
                '3' : listOfTasks[3]
              });
              setState(() {
                levelType = data['levelType'];
              });
            }),
          ],
        )
        );
      }
      odd=!odd;
    }
    return listOfButtons;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data= ModalRoute.of(context).settings.arguments;
    levelType = data['levelType'];
    levelDifficult = data['levelDifficult'];
    user_id = data['user_id'];
    futureMapOfDonuts = getAllDonuts();
    intTitle();

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
      ),
      body: FutureBuilder<Map<String,dynamic>>(
        future: futureMapOfDonuts,
        builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot){
          if(snapshot.hasData){
            mapOfDonuts = snapshot.data;
            return Column(
              children: initButtons(),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
  intTitle(){
    switch(levelType){
      case 'text':
        titleText='Текстовые задания';
        break;
      case 'image':
        titleText='Задания с картинками';
        break;
      case 'media':
        titleText='Задания с медиа';
        break;
    }
  }
}
