import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sound_stream_flutter_app/app/api/base_url.dart';

class HttpApiConnect {
  Future<dynamic> httpPostApi(String url, dynamic body) async {
    var request = http.Request('POST', Uri.parse('${BaseUrl().baseUrl}$url'));

    if (body != null) {
      request.bodyFields = body;
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(res);
      return responseJson;
    } else {
      final res = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(res);

      debugPrint(res);
      return responseJson;
    }
  }

  Future<dynamic> httpPostTojsonApi(String url, dynamic body) async {
    var request = http.Request('POST', Uri.parse('${BaseUrl().baseUrl}$url'));

    if (body != null) {
      request.body = json.encode(body);
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(res);
      return responseJson;
    } else {
      final res = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(res);

      debugPrint(res);
      return responseJson;
    }
  }

  Future<dynamic> httpPutTojsonApi(String url, dynamic body) async {
    var request = http.Request('PUT', Uri.parse('${BaseUrl().baseUrl}$url'));

    if (body != null) {
      request.body = json.encode(body);
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(res);
      return responseJson;
    } else {
      final res = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(res);

      debugPrint(res);
      return responseJson;
    }
  }

  Future<dynamic> getApi(String url) async {
    final response = await http.get(Uri.parse('${BaseUrl().baseUrl}$url'));
    if (response.statusCode != 200) {
      return ErrorHandleError().errorHandleError(response);
    } else {
      return response;
    }
  }

  Future<dynamic> putMethord(String urls, var add) async {
    final url = Uri.parse("${BaseUrl().baseUrl}$urls");

    String jsonData = json.encode(add);

    Map<String, String> headers = {"Content-Type": "application/json"};

    final response = await http.put(url, headers: headers, body: jsonData);
    if (response.statusCode != 200) {
      return ErrorHandleError().errorHandleError(response);
    } else {
      return response;
    }
  }

  Future<dynamic> httpGetApi(
    String url,
  ) async {
    var request = http.Request('GET', Uri.parse('${BaseUrl().baseUrl}$url'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();

      Map<String, dynamic> responseJson = json.decode(res);
      return responseJson;
    } else {
      final res = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(res);

      debugPrint(res);
      return responseJson;
    }
  }

  Future<dynamic> httpDeleteApi(
    String url,
  ) async {
    var request = http.Request('DELETE', Uri.parse('${BaseUrl().baseUrl}$url'));

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();

      Map<String, dynamic> responseJson = json.decode(res);
      return responseJson;
    } else {
      final res = await response.stream.bytesToString();
      Map<String, dynamic> responseJson = json.decode(res);

      debugPrint(res);
      return responseJson;
    }
  }

  Future<dynamic> post(String urls, var add) async {
    final url = Uri.parse("${BaseUrl().baseUrl}$urls");

    String jsonData = json.encode(add);

    Map<String, String> headers = {"Content-Type": "application/json"};

    final response = await http.post(url, headers: headers, body: jsonData);
    if (response.statusCode != 200) {
      return ErrorHandleError().errorHandleError(response);
    } else {
      return response;
    }
  }

  Future<dynamic> postAPICall(String url, Map param) async {
    final response = await http.post(
      Uri.parse(BaseUrl().baseUrl + url),
      body: param,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode != 200) {
      return ErrorHandleError().errorHandleError(response);
    } else {
      return response;
    }
  }

  Future<dynamic> get(
    String urls,
  ) async {
    final url = Uri.parse("${BaseUrl().baseUrl}$urls");

    Map<String, String> headers = {"Content-Type": "application/json"};

    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode != 200) {
      return ErrorHandleError().errorHandleError(response);
    } else {
      return response;
    }
  }

  Future<dynamic> delete(
    String urls,
  ) async {
    final url = Uri.parse("${BaseUrl().baseUrl}$urls");

    Map<String, String> headers = {"Content-Type": "application/json"};

    final response = await http.delete(
      url,
      headers: headers,
    );
    if (response.statusCode != 200) {
      return ErrorHandleError().errorHandleError(response);
    } else {
      return response;
    }
  }
}

Future<dynamic> postAPICall(String url, Map param) async {
  final response = await http.post(
    Uri.parse(BaseUrl().baseUrl + url),
    body: param,
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  );
  if (response.statusCode != 200) {
    return ErrorHandleError().errorHandleError(response);
  } else {
    return response;
  }
}

class ErrorHandleError {
  Future<dynamic> errorHandleError(Response response) async {
    switch (response.statusCode) {
      case 200:
        break;
      case 401:
      case 400:
      case 500:
      // return sucessToast('Check your Internet');
      case 503:
      // return sucessToast('Check your Internet');
      default:
      // errorToast("Check your Internet");
      // errorToast(response.statusText!);
    }
  }
}
