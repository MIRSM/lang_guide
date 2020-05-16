import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class mediaLevel extends StatefulWidget {
  @override
  _mediaLevelState createState() => _mediaLevelState();
}
enum TtsState { playing, stopped }

class _mediaLevelState extends State<mediaLevel> {

  FlutterTts flutterTts;
  dynamic languages;
  String language = "en-US";
  double volume = 0.5;
  double pitch = 1;
  double rate = 1;
  String _newVoiceText;
  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

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
  static const String Level_Type = 'media';
  String level_difficult;

  @override
  initState() {
    super.initState();
    initTts();
    flutterTts.setLanguage(language);
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    _newVoiceText=mapOfTasks[taskIndex]['answer'].toString();
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

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

  Widget initPlayer(){
    Row row;
    switch(mapOfTasks[taskIndex]['type']){
      case 'audio':
        row = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.volume_up, color: Colors.lightBlue,),
              onPressed: isPlaying? _stop : _speak,
            ),
            Slider(
              value: rate,
              onChanged: (newRate) {
                setState(() => rate = newRate);
              },
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: "Скорость речи: $rate",
              activeColor: Colors.lightBlue,
            )
          ],
        );

        break;
      case 'video':
        row =Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('В разработке'),
                CircularProgressIndicator()
              ],
            )
          ],
        );
        break;
    }
    return row;
  }

  Widget initMediaTask() {

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
                title:RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: mapOfTasks[taskIndex]['task'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black),
                  ),

                ),
              ),
            ),
            SizedBox(height: 30,),
            initPlayer(),//сюда вставляем аудио/видео блок
            SizedBox(height: 50,),
            Column(
              children: listOfButtons,
            ),
            Flexible(child: FractionallySizedBox(heightFactor: 0.7,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: ()async{
                    bool next = false;
                    setState(() {
                      if(!buttonPushed)  {
                        buttonPushed = true;
                        checkAnswers();
                        return;
                      }else {
                        buttonPushed = false;
                        shouldRefreshData = true;
                      }
                      if(taskIndex!=3)
                        taskIndex++;
                      else
                        next = true;
                    });
                    if(next){
                      await Navigator.pushNamed(context, '/resultLevel', arguments: {
                        'resultPoints' : resultPoints,
                        'user_id' : user_id,
                        'level_difficult' : level_difficult,
                        'level_type' : Level_Type,
                        'level_number' : level_number});
                      Navigator.pop(context);
                    }
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
    return initMediaTask();
  }
}
