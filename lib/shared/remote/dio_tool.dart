

import 'package:dio/dio.dart';

class dioTool
{
  static late Dio dio;
  static void init()async
  {
    dio = await Dio(
        BaseOptions(
          baseUrl: 'https://fcm.googleapis.com/fcm/',
          receiveDataWhenStatusError: true,
          connectTimeout: 10000,
          receiveTimeout: 10000,
        ),
    );
  }


  static Future<Response> postData ({
    required Map<String,dynamic>? data,
    Map<String,dynamic>? query,
  }) async{
    dio.options.headers={
      "Content-Type": "application/json",
      "Authorization": "key=AAAA1AzCXMk:APA91bFYkFmiuR1S9lD9ECvDypxQ4jxQ4u1L2gUDA270SG80--lSo3hbsQnTTI1PKhuvVk3OHK_XjNfE9FrwdrOSgEZqyktfrBG-7knkxMpwvaFxzhxBQlok4iD0A8v3ATFiwIjYP-xk"
    };

    return await dio.post(
      'send',
      queryParameters: query,
      data: data,
    );
  }

}
//