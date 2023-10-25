import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
class ApiHelper{
  var baseUrl = dotenv.env['BASE_URL'].toString();

  Future<http.Response> httpPostGetPut(
    int type,
    String path, {
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? queryParameters,
  }) async {
    late http.Response response;
    var url = baseUrl+path;
    print(url);
    try {
      if (type == 0) {
        response = await http.post(Uri.parse(url), headers: headers, body: body);
      }else if (type == 1) {
        var uri = Uri.parse(url);
        if (queryParameters != null) {
          uri = Uri.parse(url).replace(queryParameters: queryParameters);
        }
        response = await http.get(uri, headers: headers);
      } else if (type == 2) {
        response = await http.put(Uri.parse(url), headers: headers, body: body);
      }
      print("${response.statusCode}");
      print("${response.body}");
    } catch (e) {
      print('Error Occurred' + e.toString());
    }
    return response;
  }

  Future<http.Response> getAllAPI() async {
    late http.Response response;
    print("getAllAPI");
    var path = "";
    response = await httpPostGetPut(1, path);
    return response;
  }

  Future<http.Response> getAPIPath(String url) async {
    late http.Response response;
    var path = url.replaceAll(baseUrl, "");
    response = await httpPostGetPut(1, path);
    return response;
  }
}