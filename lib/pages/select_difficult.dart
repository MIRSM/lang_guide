import 'package:flutter/material.dart';

class SelectDifficult extends StatefulWidget {
  @override
  _SelectDifficultState createState() => _SelectDifficultState();
}

class _SelectDifficultState extends State<SelectDifficult> {
  List<String> _listOfDifficults = [
    'Начинающий',
    'Средний',
    'Продвинутый'
  ];
  Map data;
  String currentDifficult;
  TextStyle selectedTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle unSelectedTextStyle = TextStyle(color: Colors.lightBlue);
  Color selectedTextColor = Colors.black;
  Color unSelectedTextColor = Colors.lightBlue;

  void updateDifficult(String value){
    Navigator.pop(context,{
      'currentDifficult': value
    });
  }

  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    currentDifficult = data['currentDifficult'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Уровень сложности'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
            color: Colors.lightBlue,
            child: Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  color: Colors.white,
                  child: ListTile(
                    onTap: (){updateDifficult('Начинающий');},
                    title: Text(_listOfDifficults[0],
                      style: _listOfDifficults[0]== currentDifficult? selectedTextStyle:unSelectedTextStyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                  color: Colors.white,
                  child: ListTile(
                    onTap: (){updateDifficult('Средний');},
                    title: Text(_listOfDifficults[1],
                      style: _listOfDifficults[1]== currentDifficult? selectedTextStyle:unSelectedTextStyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  color: Colors.white,
                  child: ListTile(
                    onTap: (){updateDifficult('Продвинутый');},
                    title: Text(_listOfDifficults[2],
                      style: _listOfDifficults[2]== currentDifficult? selectedTextStyle:unSelectedTextStyle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
