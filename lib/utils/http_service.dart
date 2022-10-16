import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'enum.dart';

class HTTPHandler {
  Future httpRequest(
      {required String url,
      var body,
      var headers,
      required RequestType method}) async {
    log("url :$url");

    http.Response? response;
    try {
      if (method == RequestType.get) {
        response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        );
      } else if (method == RequestType.post) {
        response = await http.post(
          Uri.parse(url),
          body: Map<String, dynamic>.from(body),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        );
      } else if (method == RequestType.delete) {
        response = await http.delete(
          Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        );
      }

      log("Here is the http response");
      log("Response : ${response!.body}");
      log("Status code : ${response.statusCode}");
      var jsonResponse = await json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse;
      } else {
        Fluttertoast.showToast(msg: jsonResponse['message'].toString());
        log(response.statusCode.toString());
        return false;
      }
    } on SocketException catch (e) {
      log("In $method method exception");
      log(e.toString());
      Fluttertoast.showToast(msg: "You are in offline mode.");
      return false;
    } catch (e) {
      log("In $method method exception");
      log(e.toString());

      if (response!.statusCode == 401) {
        Fluttertoast.showToast(msg: "Invalid Auth Token\nTry Signing In Again");
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Internal Server Error");
      } else {
        Fluttertoast.showToast(msg: e.toString());
      }

      return false;
    }
  }
}
