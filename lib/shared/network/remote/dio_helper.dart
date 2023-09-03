import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
        BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/', receiveDataWhenStatusError: true,
          headers: {
          'Content-Type':'application/json'
          }
        ));
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    String lang ='ar',
    String? token ,
   required String url,
    Map<String,dynamic> ?query,
   required Map<String,dynamic> data,
}) async{
    dio?.options.headers={
      'lang':lang,
      'Authorization':token,

    };
    return await dio!.post(
        url,
        queryParameters: query,
        data: data
    );
  }

  }

