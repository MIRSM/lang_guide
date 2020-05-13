import 'package:flutter/material.dart';
import 'package:lang_guide/services/database.dart';

class ResultLevel extends StatefulWidget {

  @override
  _ResultLevelState createState() => _ResultLevelState();
}

class _ResultLevelState extends State<ResultLevel> with TickerProviderStateMixin{

  String user_id;
  String level_difficult;
  String level_type;
  String level_number;
  bool blocked =false;

  int resultPoints = 0;
  int maxPoints = 4;
  bool showResult = false;
  List<Widget> listOfDonuts=[];
  AnimationController controller;

  void CountDonuts(){
    listOfDonuts=[];
    controller = AnimationController(
        vsync: this,
        duration: Duration (seconds: 1)
    );
    for(int i = 0;i<maxPoints;i++){
      final animation = Tween(
          begin: 0.0,
          end: resultPoints> i ? 1.0:0.1
      ).animate(controller);
      listOfDonuts.add(
          FadeTransition(
            opacity: animation ,
            child: Image(image: AssetImage("assets/donut.png"), width: 50, height: 50,)
          )
        );
    }
  }
  @override
  void initState(){
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  Future<void> sendData() async{
    await Database.addUpdCompletedLevel(user_id, level_difficult, level_type, level_number, resultPoints.toString());
  }

  Widget ShowResult(BuildContext context){
    if(!blocked) {
      Map data = ModalRoute
          .of(context)
          .settings
          .arguments;
      resultPoints = data['resultPoints'];
      user_id = data['user_id'];
      level_difficult = data['level_difficult'];
      level_type = data['level_type'];
      level_number = data['level_number'];
      sendData();
      blocked = true;
    }
    CountDonuts();
    controller.forward();

    return Scaffold(
      body: SafeArea(
        child:
        Table(
            children: <TableRow>[
              TableRow(
                children:<Widget> [
                  SizedBox(height: 10,)
                ],
              ),
              TableRow(
                children:<Widget> [
                  LinearProgressIndicator(
                    value: 1,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
              TableRow(
                children:<Widget> [
                  SizedBox(height: MediaQuery.of(context).size.height*0.35,)
                ],
              ),
              TableRow(
                children:<Widget> [
                  Center(
                    child: Container(
                      //color: Colors.lightBlue,
                        height: MediaQuery.of(context).size.height*0.4,
                        child: Column(
                          children: <Widget>[
                            Text("Ваш результат",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40
                              ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: listOfDonuts,),
                            FlatButton(
                              onPressed: (){
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              shape: StadiumBorder(),
                              color: Colors.lightBlue,
                              child: Text("Готово"),
                            ),
                          ],
                        )
                    ),
                  )
                ],
              ),
            ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowResult(context);
  }
}
