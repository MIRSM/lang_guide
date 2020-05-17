import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class theoryPage extends StatefulWidget {
  @override
  _theoryPageState createState() => _theoryPageState();
}

class _theoryPageState extends State<theoryPage> {

  List<TextSpan> changeToBold(String build,String eng,String rus, String description){
    List<TextSpan> resultList=[];
    TextStyle txtStyle = TextStyle(color: Colors.black,fontSize: 12);
    TextStyle txtPr = TextStyle(color: Colors.lightBlue,fontSize: 12);
    TextStyle verbStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    var arr=build.split('`');
    for(int i=0;i<arr.length;i++){
      resultList.add(TextSpan(style: arr[i]=='V'?verbStyle:txtStyle, text: arr[i]));
    }
    resultList.add(TextSpan(style: txtPr,text: eng));
    resultList.add(TextSpan(style: txtPr,text: rus));
    resultList.add(TextSpan(style: txtStyle,text: description));
    return resultList;
  }

  Widget initTimes(String state){

    Map mapOfTimes={
        'statement':{
          'simple': {
            'present': {
              'description' : 'Повторяющиеся действия\nДействия, следующие одно за другим\nПланируемые события',
              'build' : 'V`, `V`s',
              'eng' : 'I read.',
              'rus' : 'Я читаю. (обычно, часто)'
            },
            'past' : {
              'description' : 'Действие, произошедшее в прошлом (не связанное с текущим моментом)\nПривычные, регулярные действия',
              'build' : 'V`ed, `V`2',
              'eng' : 'I readed.',
              'rus' : 'Я читал. (вчера)'
            },
            'future' : {
              'description' : 'Предположение о ходе будущих действий\nВ условных предложениях (If + Present Simple + will do)',
              'build' : 'will + `V`',
              'eng' : 'I will read.',
              'rus' : 'Я прочитаю. (завтра)',
            }
          },
          'continuous': {
            'present': {
              'description' : 'Действие, происходящее в текущий момент\nЗапланированные будущие действия',
              'build' : 'am/is/are + `V`ing',
              'eng' : 'I am reading.',
              'rus' : 'Я читаю. (сейчас)',
            },
            'past' : {
              'description' : 'Длительное действие в прошлом\nОдновременные действия',
              'build' : 'was/were + `V`ing',
              'eng' : 'I was reading.',
              'rus' : 'Я читал. (вчера, в 2 часа)',
            },
            'future' : {
              'description' : 'Действие, которое обязательно произойдет в будущем',
              'build' : 'will + `V`',
              'eng' : 'I will read.',
              'rus' : 'Я прочитаю. (завтра)',
            }
          },
          'perfect' : {
            'present': {
              'description' : 'Завершенное действие, связанное с настоящим\nДействие, идущее из прошлого по настоящий момент',
              'build' : 'have/has + `V`ed, `V`3',
              'eng' : 'I have readed.',
              'rus' : 'Я прочитал. (уже, только что)',
            },
            'past' : {
              'description' : 'Прошлое действие, которое началось и завершилось к определенному моменту в прошлом',
              'build' : 'had + `V`ed, `V`3',
              'eng' : 'I had readed.',
              'rus' : 'Я прочитал. (вчера к 3м часам, до того как...)',
            },
            'future' : {
              'description' : 'Действие, которое завершится в определенный момент в будущем',
              'build' : 'will + have +  `V`3',
              'eng' : 'I will have read.',
              'rus' : 'Я прочитаю. (завтра к 3м часам, до того, как...)',
            }
          },
          'perfectContinuous' : {
            'present': {
              'description' : 'Действие, начавшееся в прошлом и только что завершившееся',
              'build' : 'have/has + been + `V`ing',
              'eng' : 'I have been reading.',
              'rus' : 'Я читаю. (уже час, с 2х часов)',
            },
            'past' : {
              'description' : 'Длительное действие, происходившее перед другим действием',
              'build' : 'had + been + `V`ing',
              'eng' : 'I had been reading.',
              'rus' : 'Я читал. (уже 2 часа, когда он пришел)',
            },
            'future' : {
              'description' : 'Действие, которое завершится до определенного события\n(Почти не используется)',
              'build' : 'will + have + been + `V`ing',
              'eng' : 'I will have been reading.',
              'rus' : 'Я буду читать. (завтра, к тому времени, когда он придет)',
            }
          }
        },
    };

    TextStyle txtStyle = TextStyle(color: Colors.black);
    TextStyle verbStyle = TextStyle(color: Colors.pink, fontSize: 13);
    TextStyle rowNameStyle = TextStyle(color: Colors.pink, fontSize: 15);
    Table table=Table(
      border: TableBorder.symmetric(inside: BorderSide(color: Colors.black,width: 1)),
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Text(' '),
            Text('Настоящее (Present)',style: verbStyle,),
            Text('Прошедшее (Past)',style: verbStyle),
            Text('Будущее (Future)',style: verbStyle),
          ]
        ),
        TableRow(
            children: <Widget>[
              Column(children: <Widget>[
                Text('Simple\n\n',style: rowNameStyle,),
                Image.asset('assets/donut.png',width: 25,height: 25,),
                Text('\n\n'),
                Image.asset('assets/donut.png',width: 25,height: 25,)
              ],),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                 children: changeToBold(mapOfTimes[state]['simple']['present']['build']+'\n\n',
                      mapOfTimes[state]['simple']['present']['eng']+'\n',
                      mapOfTimes[state]['simple']['present']['rus']+'\n\n',
                      mapOfTimes[state]['simple']['present']['description']+'\n')
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                     children: changeToBold(mapOfTimes[state]['simple']['past']['build']+'\n\n',
                        mapOfTimes[state]['simple']['past']['eng']+'\n',
                        mapOfTimes[state]['simple']['past']['rus']+'\n\n',
                        mapOfTimes[state]['simple']['past']['description']+'\n')
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['simple']['future']['build']+'\n\n',
                        mapOfTimes[state]['simple']['future']['eng']+'\n',
                        mapOfTimes[state]['simple']['future']['rus']+'\n\n',
                        mapOfTimes[state]['simple']['future']['description']+'\n')
                ),
              ),
            ]
        ),
        TableRow(
            children: <Widget>[
              Column(children: <Widget>[
                Text('Continuous\n\n',style: rowNameStyle,),
                Image.asset('assets/donut.png',width: 25,height: 25,),
                Text('\n\n'),
                Image.asset('assets/donut.png',width: 25,height: 25,)
              ],),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['continuous']['present']['build']+'\n\n',
                        mapOfTimes[state]['continuous']['present']['eng']+'\n',
                        mapOfTimes[state]['continuous']['present']['rus']+'\n\n',
                        mapOfTimes[state]['continuous']['present']['description']+'\n')
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['continuous']['past']['build']+'\n\n',
                        mapOfTimes[state]['continuous']['past']['eng']+'\n',
                        mapOfTimes[state]['continuous']['past']['rus']+'\n\n',
                        mapOfTimes[state]['continuous']['past']['description']+'\n')
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['continuous']['future']['build']+'\n\n\n',
                        mapOfTimes[state]['continuous']['future']['eng']+'\n',
                        mapOfTimes[state]['continuous']['future']['rus']+'\n\n',
                        mapOfTimes[state]['continuous']['future']['description']+'\n')
                ),
              ),
            ]
        ),
        TableRow(
            children: <Widget>[
              Column(children: <Widget>[
                Text('Perfect\n\n',style: rowNameStyle,),
                Image.asset('assets/donut.png',width: 25,height: 25,),
                Text('\n\n\n'),
                Image.asset('assets/donut.png',width: 25,height: 25,)
              ],),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['perfect']['present']['build']+'\n\n',
                        mapOfTimes[state]['perfect']['present']['eng']+'\n',
                        mapOfTimes[state]['perfect']['present']['rus']+'\n\n',
                        mapOfTimes[state]['perfect']['present']['description']+'\n')
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['perfect']['past']['build']+'\n\n',
                        mapOfTimes[state]['perfect']['past']['eng']+'\n',
                        mapOfTimes[state]['perfect']['past']['rus']+'\n\n',
                        mapOfTimes[state]['perfect']['past']['description']+'\n')
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['perfect']['future']['build']+'\n\n',
                        mapOfTimes[state]['perfect']['future']['eng']+'\n',
                        mapOfTimes[state]['perfect']['future']['rus']+'\n\n',
                        mapOfTimes[state]['perfect']['future']['description']+'\n')
                ),
              ),
            ]
        ),
        TableRow(
            children: <Widget>[
              Column(children: <Widget>[
                Text('Perfect Continuous\n\n',style: rowNameStyle,),
                Image.asset('assets/donut.png',width: 25,height: 25,),
                Text('\n\n'),
                Image.asset('assets/donut.png',width: 25,height: 25,)
              ],),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['perfectContinuous']['present']['build']+'\n\n',
                        mapOfTimes[state]['perfectContinuous']['present']['eng']+'\n',
                        mapOfTimes[state]['perfectContinuous']['present']['rus']+'\n\n',
                        mapOfTimes[state]['perfectContinuous']['present']['description']+'\n')
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['perfectContinuous']['past']['build']+'\n\n',
                        mapOfTimes[state]['perfectContinuous']['past']['eng']+'\n',
                        mapOfTimes[state]['perfectContinuous']['past']['rus']+'\n\n',
                        mapOfTimes[state]['perfectContinuous']['past']['description']+'\n')
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: txtStyle,
                    children: changeToBold(mapOfTimes[state]['perfectContinuous']['future']['build']+'\n\n',
                        mapOfTimes[state]['perfectContinuous']['future']['eng']+'\n',
                        mapOfTimes[state]['perfectContinuous']['future']['rus']+'\n\n',
                        mapOfTimes[state]['perfectContinuous']['future']['description']+'\n')
                ),
              ),
            ]
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Времена'),
      ),
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),child: table)),
    );
  }

  Widget initPronouns(){

  }

  Widget initPrepositions(){

  }

  Widget initVerbs(){

  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;

    switch(data['pageType']){
      case 'times':
        return initTimes('statement');
      case 'pronouns':
        return initPronouns();
      case 'prepositions':
        return initPrepositions();
      case 'verbs':
        return initVerbs();
    }
    return Container();
  }
}
