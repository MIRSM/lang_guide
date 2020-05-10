import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lang_guide/services/database.dart';

class textLevel extends StatefulWidget {
  @override
  _textLevelState createState() => _textLevelState();
}

class _textLevelState extends State<textLevel> {
  int levelNumber;
  int taskIndex = 0;
  List<Map<String,dynamic>> mapOfTasks=[];
  String finalAnswer='';
  List<bool>  listOfButtonsStates=[];
  List<Widget> listOfButtons=[];
  bool buttonPushed = false;

  void checkAnswers(){
    buttonPushed = false;
    if(finalAnswer == mapOfTasks[taskIndex]['answer'].toString()){
      //все правильно
      //добавить очки
    }
    var splited = finalAnswer.split(' ');
    for(int i = 0; i<splited.length;i++){
    }
  }

  List<Widget> WidgetinitAnswerFlatButtons(int answersCount, int additionalCount){
    List<Widget> l=[];
    int createdAnswers, createdAdditional =0;
    var answers = [...mapOfTasks[taskIndex]['answer'].toString().split(' '), ...mapOfTasks[taskIndex]['additional'].toString().split(' ')];
    answers.shuffle();

    l.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              
            ]
          ),
        )
      ],
    ));

    for(int i=0;i<answers.length;i++){
      listOfButtonsStates.add(false);
      listOfButtons.add(
        FlatButton(
          onPressed: (){
            if(!listOfButtonsStates[i]){
              setState(() {
                finalAnswer+=answers[i]+' ';
              });
            }else{
              setState(() {
                finalAnswer = finalAnswer.replaceFirst(finalAnswer+' ', '');
              });
            }
            listOfButtonsStates[i]=!listOfButtonsStates[i];
          },
          key: Key(answers[i]),
          child: Text(answers[i]),
        )
      );
    }
    return l;
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
            Text(
              mapOfTasks[taskIndex].keys.first,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black),
            ),
            Text(
                mapOfTasks[taskIndex][mapOfTasks[taskIndex].keys.first],
                style: TextStyle(
                    fontSize: 18,
                  color: Colors.black54
                )),
            SizedBox(height: 50,),
            Container(
              height: 50,
              color: Colors.black12,
              child: Column(
                children: WidgetinitAnswerFlatButtons(mapOfTasks[taskIndex]['answer'].toString().split(' ').length,
                    mapOfTasks[taskIndex]['additional'].toString().split(' ').length),
              )
            ),
            FlatButton(
              onPressed: (){
              setState(() {
                if(!buttonPushed) {
                  buttonPushed = true;
                  checkAnswers();
                  return;
                }
                if(taskIndex==3){
                  return;
                }
                taskIndex++;
              });},
              child: Text("Далее"),
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
      for(int i = 0;i<4;i++){
        mapOfTasks.add(data['$i']);
      }
    }
    return initTextTask();
  }
}


