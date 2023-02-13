import 'package:dio/dio.dart';
import '../../core/string.dart';

class DioHelper{
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
    ));
  }
  static Future<dynamic> getData({
    required String endPoint, String? query,}) async {
    Response response = await dio.get('$endPoint?api_key=$apiKey&$query');
    return response.data;
  }

  static Future<Response> postData({ required String endPoint,Map<String,
      dynamic>? body}) async{
    return await dio.post(endPoint, data: body);
  }

}