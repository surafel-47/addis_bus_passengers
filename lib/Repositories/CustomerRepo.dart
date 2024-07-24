// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/CustomerModel.dart';
import 'myUtiils.dart';

import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as htmlDom;

class CustomerRepo extends ChangeNotifier {
  static CustomerModel customerModel = CustomerModel();

  static Future<dynamic> getPendingTickets() async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/getPendingTickets?passenger_obj_id=${customerModel.objectId}';
    return fetchData(Url: url);
  }

  static Future<dynamic> getConfirmedTickets() async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/getConfirmedTickets?passenger_obj_id=${customerModel.objectId}';
    return fetchData(Url: url);
  }

  static Future<dynamic> bookTicket(String startStation, String endStation) async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/bookTicket?passenger_obj_id=${customerModel.objectId}&start_station=$startStation&end_station=$endStation';
    return fetchData(Url: url);
  }

  static Future<dynamic> getStationsList() async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/getStationsList';
    return fetchData(Url: url);
  }

  static Future<dynamic> getSingleTicket(String ticketId) async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/getSingleTicket?passenger_obj_id=${customerModel.objectId}&ticket_id=$ticketId';
    return fetchData(Url: url);
  }

  static Future<dynamic> changePassengerPin(String newPin) async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/changePassengerPin?passenger_obj_id=${customerModel.objectId}&new_pin=$newPin';
    return fetchData(Url: url);
  }

  static Future<dynamic> payBalance() async {
    final String url = '${MyUtils.BASE_URL}/passengerApi/payBalance?passenger_obj_id=${customerModel.objectId}';
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
