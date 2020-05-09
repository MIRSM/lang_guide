import 'package:flutter/material.dart';
import 'package:lang_guide/pages/auth.dart';
import 'package:lang_guide/pages/loading.dart';
import 'package:lang_guide/pages/main_menu.dart';
import 'package:lang_guide/pages/select_difficult.dart';
import 'package:lang_guide/pages/select_level.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/authorization',
    routes: {
        '/': (context)=> Loading(),
        '/authorization': (context) => Authorization(),
        '/mainMenu': (context) => MainMenu(),
        '/selectDifficult': (context) => SelectDifficult(),
        '/selectLevel' : (context) =>  SelectLevel(),
        //'/options': (context) => Options(),
        //'/TrainingType': (context) => TrainingType(),
        //'/TrainingLevel' : (context) => TrainingLevel(),
    },
  ));
}
