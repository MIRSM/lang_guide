import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vk_sdk/flutter_vk_sdk.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lang_guide/services/database.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

String currentDifficult='Начинающий';

class _MainMenuState extends State<MainMenu> with WidgetsBindingObserver {

  int _selectedWidgetIndex = 0;
  Map data={};
  static String firstName = 'Unkown';
  static String lastName  = 'Unkown';
  static String id        = '';
  static String avatar    = '';
  static Widget widget1   = Column();
  static Widget widget3   = Column();

  static const Color SpecialTextColor = Colors.black;
  static const Color UsualTextColor = Colors.lightBlue;

  List<Widget> _widgets = <Widget>[
    widget1,
    Center(
      child: Text('Грамматика'),
    ),
    widget3,
  ];

  void updateWidgets(){
    _widgets[0] = Center(
      child: Card(
        color: UsualTextColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              color: Colors.white,
              child: ListTile(
                title: Text('Текст',style: TextStyle(fontSize: 20,color: SpecialTextColor)),
                leading: Icon(Icons.textsms, color: UsualTextColor),
                onTap: () async{
                  await Navigator.pushNamed(context, '/selectLevel',arguments: {
                    'levelType' : 'text',
                    'levelDifficult' :currentDifficult,
                  });
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
              color: Colors.white,
              child: ListTile(
                title: Text('Картинки',style: TextStyle(fontSize: 20,color: SpecialTextColor)),
                leading: Icon(Icons.image, color: UsualTextColor),
                onTap: () {},
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              color: Colors.white,
              child: ListTile(
                title: Text('Медиа',style: TextStyle(fontSize: 20,color: SpecialTextColor)),
                leading: Icon(Icons.headset, color: UsualTextColor),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );

    _widgets[2] =Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            color: UsualTextColor,
            child: ListTile(
              title: Text('$firstName $lastName',
                  style:  TextStyle(fontSize: 25, color: Colors.white)),
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatar),
              ),
            ),
          ),
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.45,
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
            color: UsualTextColor,
            child: Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  color: Colors.white,
                  child: ListTile(
                    title: RichText(
                        text: TextSpan(
                          //style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text:"Уровень:\n",style: TextStyle(fontSize: 25.0,color: UsualTextColor) ),
                              TextSpan(text:"$currentDifficult", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,color: SpecialTextColor)),//orange[400]
                            ])),
                    leading: Icon(Icons.arrow_forward,size: 40,color: UsualTextColor,),
                    onTap: () async{
                      dynamic result = await Navigator.pushNamed(context, '/selectDifficult',arguments: {
                        'currentDifficult' : currentDifficult
                      });
                      setState(() {
                        data={
                          'currentDifficult' : result['currentDifficult']
                        };
                      });},
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                  color: Colors.white,
                  child: ListTile(
                    title: Text("О приложении", style: TextStyle(fontSize: 25.0,color: SpecialTextColor)),
                    leading: Icon(MdiIcons.information,size: 40,color: UsualTextColor,),
                    onTap: (){},
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                  color: Colors.white,
                  child: ListTile(
                    title: Text("Выйти", style: TextStyle(fontSize: 25.0,color: SpecialTextColor)),
                    leading: Icon(MdiIcons.vk,size: 40,color: UsualTextColor,),
                    onTap: (){
                      FlutterVKSdk.logout();
                      Navigator.pushNamed(context, '/authorization');
                    },
                  ),
                ),
              ],
            ),
          ),
        ]);
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedWidgetIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state==AppLifecycleState.inactive){
      Database.updLastDifficult(id, currentDifficult);
    }
  }

  @override
  Widget build(BuildContext context) {

    data= data.isNotEmpty?data : ModalRoute.of(context).settings.arguments;

    firstName = data['firstName'] == null? firstName: data['firstName'];
    lastName = data['lastName']== null? lastName: data['lastName'];
    avatar = data['avatar']== null? avatar: data['avatar'];
    id = data['user_id'] == null? id : data['user_id'];
    currentDifficult = data['currentDifficult'] == null?  currentDifficult: data['currentDifficult'];

    updateWidgets();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue[700],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.glasses),
            title: Text('Задания'),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.book),
            title: Text('Теория'),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountSettings),
            title: Text('Настройки'),
          ),
        ],
        currentIndex: _selectedWidgetIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: SpecialTextColor,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: _widgets.elementAt(_selectedWidgetIndex),
      ),
    );
  }
}
