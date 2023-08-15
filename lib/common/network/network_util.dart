import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/myLog.dart';

String host = "https://newsapi.org/v2/everything?q=";
Dio? dio;

Future globalRequest({
  required String searchName,
  required Map<String, dynamic> body,
  bool isGet = false,
}) async {
  // Adjout de key
  host +=
      "$searchName&from=2023-07-15&sortBy=publishedAt&apiKey=${dotenv.env['API_KEY'] ?? ""}";
  BaseOptions options =
      BaseOptions(baseUrl: host, contentType: "application/json", headers: {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "*",
    "Access-Control-Allow-Methods": "*",
  });
  dio = Dio(options);

  Map<String, dynamic> httpBody = Map<String, dynamic>.from(body);

  log("host: $host \nsearchName: $searchName \nparams: [$httpBody]");
  Map<String, dynamic> headers = ({});
  Response response;
  try {
    if (isGet) {
      response = await dio!.get(host,
          queryParameters: httpBody, options: Options(headers: headers));
    } else {
      response = await dio!
          .post(host, data: httpBody, options: Options(headers: headers));
    }
  } catch (e) {
    AppLog.i("network error:$e");
    return e;
  }
  var result = response.data;
  // AppLog.i("response:$result");
  return result;
}
