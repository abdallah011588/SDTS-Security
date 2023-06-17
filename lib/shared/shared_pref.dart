

import 'package:shared_preferences/shared_preferences.dart';

class Shared{

  static late SharedPreferences shared;

  static init()async
  {
    shared=await SharedPreferences.getInstance();
  }


  static Future<bool> setData({required String key, required dynamic value})async
  {
    if(value is String)
    {
      return await shared.setString(key, value);
    }
    if(value is bool)
    {
      return await shared.setBool(key, value);
    }
    else
    {
      return shared.setDouble(key, value);
    }

  }


  static dynamic getBool({required String key,})
  {
    return shared.getBool(key);
  }

  static String? getString({required String key,})
  {
    return shared.getString(key);
  }

  static Future<bool> removeData({required String key})async
  {
    return await shared.remove(key);
  }


}