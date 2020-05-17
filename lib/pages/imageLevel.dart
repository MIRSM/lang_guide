import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class imageLevel extends StatefulWidget {
  @override
  _imageLevelState createState() => _imageLevelState();
}

class _imageLevelState extends State<imageLevel> {

  int resultPoints = 0;
  int taskIndex = 0;
  List<Map<String,dynamic>> mapOfTasks=[];
  List<Color> listOfColors=[];
  bool shouldRefreshData = true;
  var finalAnswerColor = Colors.black;
  ValueKey<String> rightAnswer;
  List<String> answers;
  Future<Map<String,List<Image>>> futureMapOfImages;
  Map<String,List<Image>> mapOfImages;
  bool isButtonPushed =false;
  List<bool> listIsButtonPushed;
  bool isRightPushed = false;
  List<double> whenRightPushed=[100,100,100,100];

  String level_number;
  String user_id;
  static const String Level_Type = 'image';
  String level_difficult;

  Widget initImageInkWell(int index, bool isRightAnswer){
    Color backgroundColor = Colors.transparent;
    if(isButtonPushed){
      backgroundColor=isRightAnswer?Colors.green:Colors.red;
    }

    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          splashColor: Colors.purple, // inkwell color
          child: Container(color: backgroundColor,width: whenRightPushed[index], height: whenRightPushed[index], child: mapOfImages['$taskIndex'][index],),
          onTap: (){
            setState(() {
              if(!isButtonPushed){
                isButtonPushed = true;
                isRightPushed = true;
                whenRightPushed[index]=140;
                if(mapOfImages['$taskIndex'][index].key ==rightAnswer){
                  resultPoints++;
                }
                return;
              }
            });
          },
        ),
      ),
    );
  }

  Widget getImage(String path) {
    return FadeInImage.memoryNetwork(
        fadeInCurve: Curves.bounceIn,
        placeholder: kTransparentImage,
        image: 'http://192.168.0.105$path',
        height: MediaQuery.of(context).size.height*0.35,
        width: MediaQuery.of(context).size.height*0.3,);
  }

  Future<Map<String,List<Image>>> initImages()async{
    Map<String,List<Image>> result= Map<String,List<Image>>();
    for(int i=0;i<4;i++){
      answers = [
        ...mapOfTasks[i]['answerImg'].toString().split(' '),
        ...mapOfTasks[i]['additionalImg'].toString().split(' ')
      ];
      List<Image> listOfImage=[];
      for(int j=0;j<4;j++)
        listOfImage.add(
          Image(image: NetworkImage('http://192.168.0.105${answers[j]}'),
            key: ValueKey<String>(answers[j]),
            height: MediaQuery.of(context).size.height*0.35,
            width: MediaQuery.of(context).size.height*0.3,));
      listOfImage.shuffle();
      result['$i']=listOfImage;
    }
    return result;
  }

  void initAnswers(){
    if(shouldRefreshData) {
      answers = [
        ...mapOfTasks[taskIndex]['answerImg'].toString().split(' '),
        ...mapOfTasks[taskIndex]['additionalImg'].toString().split(' ')
      ];
      whenRightPushed=[100,100,100,100];
      isRightPushed = false;
      rightAnswer =ValueKey(answers[0]);
      answers.shuffle();
      shouldRefreshData = false;
      isButtonPushed =false;
      listIsButtonPushed = [false,false,false,false];
    }
  }

  Widget initImageTable(){

    List<Row> listOfRows=[];
    bool first = true;
    int j=0;
    for(int i=0;i<4;i++){
      bool isRightAnswer = mapOfImages['$taskIndex'][i].key ==rightAnswer;

      if(first){
        listOfRows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            initImageInkWell(i,isRightAnswer)
          ]
        ));
      }else{
        listOfRows[j].children.add(
            initImageInkWell(i,isRightAnswer)
        );
        j++;
      }
      first=!first;
    }
    return Column(mainAxisAlignment: MainAxisAlignment.center,children: listOfRows, );
  }

  Widget initImageTask(){
    return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            LinearProgressIndicator(
              value: taskIndex.toDouble()*0.25,
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
                    children: <TextSpan>[
                      TextSpan(
                        text: mapOfTasks[taskIndex]['answerWord'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.pink)
                      )
                    ],
                  ),
                  ),
              ),
            ),
            SizedBox(height: 30,),
            initImageTable(),
            Flexible(child: FractionallySizedBox(heightFactor: 0.7,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: ()async{
                    if(taskIndex==3){
                      await Navigator.pushNamed(context, '/resultLevel', arguments: {
                        'resultPoints' : resultPoints,
                        'user_id' : user_id,
                        'level_difficult' : level_difficult,
                        'level_type' : Level_Type,
                        'level_number' : level_number});
                      Navigator.pop(context);
                      return;
                    }
                    setState(() {
                      if(!isButtonPushed)  {
                        isButtonPushed = true;
                        return;
                      }else {
                        isButtonPushed = false;
                        shouldRefreshData = true;
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
    if(shouldRefreshData)
    futureMapOfImages = initImages();
    initAnswers();

    return Scaffold(
      body: FutureBuilder<Map<String,dynamic>>(
        future: futureMapOfImages,
        builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot){
          if(snapshot.hasData){
            mapOfImages = snapshot.data;
            return initImageTask();
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
