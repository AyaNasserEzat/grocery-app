import 'package:dio/dio.dart';

class ApiSevice {
  final Dio dio = Dio();
  Future<Response> post(
      {required body, required String url, required String token,String? contentType}) async {
    var response = await dio.post(url,
        data: body,
        options: Options(
          contentType:contentType ,
          headers: {'Authorization': "Bearer $token"},
        ));
    return response;
  }
}
