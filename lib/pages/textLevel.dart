import 'dart:ui';
import 'package:flutter/material.dart';

class textLevel extends StatefulWidget {
  @override
  _textLevelState createState() => _textLevelState();
}

class _textLevelState extends State<textLevel> {

  int resultPoints = 0;
  int taskIndex = 0;
  List<Map<String,dynamic>> mapOfTasks=[];
  String finalAnswer='';
  List<bool>  listOfButtonsStates=[];
  List<Widget> listOfButtons=[];
  List<Color> listOfColors = [];
  bool buttonPushed = false;
  bool shouldRefreshData = true;
  var finalAnswerColor = Colors.black;
  String rightAnswer='';
  List<String> answers;

  String level_number;
  String user_id;
  static const String Level_Type = 'text';
  String level_difficult;

  void checkAnswers(){
    setState(() {
      rightAnswer = mapOfTasks[taskIndex]['answer'].toString();
      finalAnswer = finalAnswer.trimRight();
      if(finalAnswer == rightAnswer){
        finalAnswerColor = Colors.green;
        resultPoints++;
        //все правильно
      }else{
        finalAnswerColor = Colors.red;
      }
    });
  }

  List<Widget> WidgetinitAnswerFlatButtons(){
    listOfButtons=[];
    if(shouldRefreshData) {
      finalAnswerColor = Colors.black;
      listOfButtonsStates=[];
      listOfColors=[];
      answers = [
        ...mapOfTasks[taskIndex]['answer'].toString().split(' '),
        ...mapOfTasks[taskIndex]['additional'].toString().split(' ')
      ];
      answers.shuffle();
      finalAnswer = '';
      rightAnswer = '';
      shouldRefreshData = false;
      for(int i=0;i<answers.length;i++){
        listOfButtonsStates.add(false);
        listOfColors.add(Colors.lightBlue);
      }
    }

    listOfButtons.add(
      Text(finalAnswer, style: TextStyle(fontSize: 20,color: finalAnswerColor))
    );
    listOfButtons.add(Text(rightAnswer,style: TextStyle(fontSize: 20)));
    listOfButtons.add (
        SizedBox(height: 30,)
    );
    List<Widget> tempList=[];
    Table table = Table(children: [], );
    for(int i=0;i<answers.length;i++){
      if((i!=0 && i%3 == 0)){
        table.children.add(TableRow(children: tempList));
        tempList=[];
        }
      tempList.add(
        ButtonTheme(
          minWidth: 10,
          child: FlatButton(
            onPressed: buttonPushed? (){} : (){
              if(!listOfButtonsStates[i]){
                setState(() {
                  finalAnswer+=answers[i]+' ';
                  listOfColors[i] = Colors.grey;
                });
              }else{
                setState(() {
                  finalAnswer = finalAnswer.replaceFirst(answers[i]+' ', '');
                  listOfColors[i] = Colors.lightBlue;
                });
              }
              listOfButtonsStates[i]=!listOfButtonsStates[i];
            },
            shape: StadiumBorder(),
            color: listOfColors[i],//Colors.lightBlue,
            child: Text(answers[i], style: TextStyle(color: Colors.white),),//listOfColors[i]),),
          ),
        ),
      );
    }
    for(int i =tempList.length;i<3;i++){
      tempList.add(FlatButton());
    }
    table.children.add(TableRow(children: tempList));
    listOfButtons.add(Container( padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),child: table));
    return listOfButtons;
  }

  Widget initTextTask() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            LinearProgressIndicator(
              value: taskIndex.toDouble()*25*0.01,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              backgroundColor: Colors.grey,
            ),
            SizedBox(height: 50,),
            Card(
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              color: Colors.lightBlue,
              child: ListTile(
                title:Text(
                  mapOfTasks[taskIndex].keys.first,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Text(
                mapOfTasks[taskIndex][mapOfTasks[taskIndex].keys.first],
                style: TextStyle(
                    fontSize: 20,
                  color: Colors.black54
                )),
            SizedBox(height: 50,),
            Column(
              children: listOfButtons,
            ),
            Flexible(child: FractionallySizedBox(heightFactor: 0.7,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    setState(() {
                    if(!buttonPushed)  {
                      buttonPushed = true;
                      checkAnswers();
                      return;
                    }else {
                      buttonPushed = false;
                      shouldRefreshData = true;
                    }
                    if(taskIndex==3){
                      Navigator.pushReplacementNamed(context, '/resultLevel', arguments: {
                        'resultPoints' : resultPoints,
                        'user_id' : user_id,
                        'level_difficult' : level_difficult,
                        'level_type' : Level_Type,
                        'level_number' : level_number});
                      return;
                    }
                    taskIndex++;
                  });
                  },
                  shape: StadiumBorder(),
                  color: Colors.lightBlue,
                  child: Text("Далее"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(mapOfTasks.isEmpty){
      final Map<String,dynamic> data = ModalRoute.of(context).settings.arguments;
      user_id = data['user_id'];
      level_difficult = data['difficult'];
      level_number = data['level_number'];
      for(int i = 0;i<4;i++){
        mapOfTasks.add(data['$i']);
      }
    }
    WidgetinitAnswerFlatButtons();
    return initTextTask();
  }
}


