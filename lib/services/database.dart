import 'dart:convert';
import 'package:http/http.dart' as http;

class Database {
  static String db_name = "lang_guide";
  static String tb_users = "users";
  static String tb_easy_level = "easy_level";
  static String tb_medium_level = "medium_level";
  static String tb_hard_level = "hard_level";

  static const ROOT = 'http://192.168.0.105/DbScript.php';

  static const _GET_COMP_LVLS_ACTION = 'GET_COMP_LVLS';
  static const _CHECK_OR_ADD_USR_ACTION = 'CHECK_ADD_USR';
  static const _UPD_LAST_DIFF_ACTION = 'UPD_LAST_DIFF';
  static const _UPD_COMP_LVL_ACTION = 'ADD_UPD_COMP_LVL';
  static const _GET_EASY_TXT_TASK   = 'GET_EASY_TXT_TASK';
  static const _GET_EASY_IMG_TASK   = 'GET_EASY_IMG_TASK';
  static const _GET_EASY_MEDIA_TASK   = 'GET_EASY_MEDIA_TASK';

 static String translateLevelDifficult(String level_difficult){
    switch(level_difficult){
      case 'Начинающий':
        return tb_easy_level;
      case 'Средний':
        return tb_medium_level;
      case 'Продвинутый':
        return Database.tb_hard_level;
    }
  }


  static Future<String> checkOrAddUser(String user_id, String first_name, String last_name) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _CHECK_OR_ADD_USR_ACTION;
      map['user_id'] = user_id;
      map['first_name'] = first_name;
      map['last_name'] = last_name;
      map['last_difficult'] = 'Начинающий';

      final response = await http.post(ROOT, body: map);
      print('addUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> updLastDifficult(String user_id,String last_difficult) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _UPD_LAST_DIFF_ACTION;
      map['user_id'] = user_id;
      map['last_difficult'] = last_difficult;

      final response = await http.post(ROOT, body: map);
      print('updLastDifficult Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    }catch(e){
      return "exc error";
    }
  }

  static Future<String> addUpdCompletedLevel(String user_id,String level_difficult, String level_type, String level_number, String points) async {
    try{
      var map = Map<String,dynamic>();
      map['action'] = _UPD_COMP_LVL_ACTION;
      map['user_id'] = user_id;
      map['level_difficult'] = translateLevelDifficult(level_difficult);
      map['level_type'] = level_type;
      map['level_number'] = level_number;
      map['points'] = points;

      final response = await http.post(ROOT, body: map);
      print('updCompletedLevel Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    }catch(e){
      print (e);
      return "exc error";
    }
  }

  static Future<List<Map<String, dynamic>>> getCompletedLevels(String user_id, String level_difficult, String level_type) async{

    List<Map<String, dynamic>>resultList=[];
    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_COMP_LVLS_ACTION;
      map['user_id'] = user_id;
      map['level_difficult'] = translateLevelDifficult(level_difficult);
      map['level_type'] = level_type;

      final response = await http.post(ROOT, body: map);
      print('getCompletedLevels Response: ${response.body}');
      if(response.body == 'zero')
        return resultList;
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      resultList = parsed.toList();

      if (200 == response.statusCode) {
        return resultList;
      } else {
        return resultList;
      }
    }catch(e){
      print (e);
      return resultList;
    }
  }

  static Future<List<Map<String, dynamic>>> getEasyTextTasks(int level) async{
    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_EASY_TXT_TASK;
      map['level'] = level.toString();

      final response = await http.post(ROOT, body: map);
      //print('getEasyTextTasks ${level} Response: ${response.body}');
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> resultList = parsed.toList();

      if (200 == response.statusCode) {
        return resultList;
      } else {
        return [];
      }
    }catch(e){
      print(e);
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getEasyImageTasks(int level) async{
    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_EASY_IMG_TASK;
      map['level'] = level.toString();

      final response = await http.post(ROOT, body: map);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> resultList = parsed.toList();

      if (200 == response.statusCode) {
        return resultList;
      } else {
        return [];
      }
    }catch(e){
      print(e);
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getEasyMediaTasks(int level) async{
    try{
      var map = Map<String,dynamic>();
      map['action'] = _GET_EASY_MEDIA_TASK;
      map['level'] = level.toString();

      final response = await http.post(ROOT, body: map);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> resultList = parsed.toList();

      if (200 == response.statusCode) {
        return resultList;
      } else {
        return [];
      }
    }catch(e){
      print(e);
      return [];
    }
  }
}

