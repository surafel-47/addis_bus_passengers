// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'myUtiils.dart';

class LoginRepo extends ChangeNotifier {
  static Future<dynamic> login(String phoneNo, String pin) async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/login?phone_no=$phoneNo&pin=$pin';

    return fetchData(Url: url);
  }

  static Future<dynamic> createAccount(String phoneNo, String pin, String name) async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/createAccount?phone_no=$phoneNo&pin=$pin&name=$name';

    return fetchData(Url: url);
  }

  static Future<dynamic> ping() async {
    final String url = '${MyUtils.BASE_URL}/ping';

    return fetchData(Url: url);
  }

  //----------------------------------------------------------------------------------------------------
  //----------------------Fetch Method for all Requests-----------------------------------
  static Future<dynamic> fetchData({
    String requestType = 'GET',
    required String Url,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    http.Response response;

    Duration timeOutDuration = const Duration(seconds: 5);

    try {
      if (requestType == 'GET') {
        response = await http.get(Uri.parse(Url), headers: headers).timeout(timeOutDuration, onTimeout: () {
          throw const SocketException('Request timed out');
        });
      } else if (requestType == 'POST') {
        response = await http
            .post(
          Uri.parse(Url),
          headers: headers,
          body: json.encode(body),
        )
            .timeout(timeOutDuration, onTimeout: () {
          throw const SocketException('Request timed out');
        });
      } else {
        throw Exception('Invalid request type');
      }

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        return data;
      } else {
        Map<String, dynamic> errorData = json.decode(response.body);
        throw errorData['msg'].toString();
      }
    } on SocketException catch (e) {
      throw 'Unable to Connect  (S)';
    } on HttpException catch (e) {
      throw 'Unable to Connect (H)';
    } on FormatException catch (e) {
      throw 'FormatException';
    } catch (e) {
      throw '$e';
    }
  }
}
