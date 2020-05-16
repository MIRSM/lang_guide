import 'package:flutter_vk_sdk/flutter_vk_sdk.dart';
import 'package:flutter_vk_sdk/vk_scope.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:lang_guide/services/database.dart';

const String appId = '7442177';
const String apiVersion = '5.103';

class Authorization extends StatefulWidget {
  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  int id;
  String token;
  String firstName='Unkown';
  String lastName='Unkown';
  String level_difficult = 'Начинающий';
  String avatar = 'https://1001freedownloads.s3.amazonaws.com/vector/thumb/75167/1366695174.png';

  initVKSdk() {
    return FlutterVKSdk.init(appId: appId,apiVersion: apiVersion);
  }

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
  }
  Future<Map> getInfo() async{
    Response response = await get('https://api.vk.com/method/users.get?user_ids=$id&fields=crop_photo&access_token=$token&v=$apiVersion');
    return jsonDecode(response.body)['response'][0];
  }

  void vkLogin() async {
    await initVKSdk();
    await FlutterVKSdk.login(
      scope: '${VKScope.email}',
      onSuccess: (res) async {
        token = res.token;
        id = res.userId;
        Map result = await getInfo();
        String check_result = await Database.checkOrAddUser(id.toString(), firstName, lastName);
        if(check_result != 'error'){
          level_difficult = check_result;
        }

        setState(() {
          firstName = result['first_name'];
          lastName = result['last_name'];
          avatar = result['crop_photo']['photo']['sizes'][4]['url'];
          Navigator.pushNamed(context, '/mainMenu',arguments: {
            'firstName': firstName,
            'lastName': lastName,
            'avatar': avatar,
            'user_id' : id.toString(),
            'currentDifficult' : level_difficult
          });
        });
      },
      onError: (error) {
        print('LOGIN ERROR: $error}');
        setState(() {
          firstName = 'error';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Lang guide', style: TextStyle(fontSize: 60.0,color: Colors.white)),
            SizedBox(height: 20,),
            FlatButton.icon(
                icon: Icon(MdiIcons.vk,size: 40,color: Colors.white,),
                onPressed: vkLogin,
                color: Colors.blue[800],
                padding: EdgeInsets.all(10.0),
                label: Text("Авторизироваться", style: TextStyle(fontSize: 20.0,color: Colors.white))
            ),
          ],
        ),
      ),
    );
  }

}