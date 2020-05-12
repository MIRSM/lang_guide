import 'package:flutter/material.dart';

class ResultLevel extends StatefulWidget {

  @override
  _ResultLevelState createState() => _ResultLevelState();
}

class _ResultLevelState extends State<ResultLevel> with TickerProviderStateMixin{

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

  Widget ShowResult(BuildContext context){
    Map data = ModalRoute.of(context).settings.arguments;
    resultPoints = data['resultPoints'];
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
