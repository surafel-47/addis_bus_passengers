// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:math';

import 'package:intl/intl.dart';

class MyUtils {
  static String BASE_URL = 'http://192.168.8.110:3000';

  static String formatTimeOnly(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String formateDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MMM dd,yyyy HH:mm a').format(dateTime);
  }

  static void validatePin(String pin) {
    // Regular expression for a 4-digit numeric PIN code
    RegExp pinRegex = RegExp(r'^\d{4}$');

    // Check if the input pin matches the regex pattern
    if (!pinRegex.hasMatch(pin)) {
      throw 'Invalid PIN code. Please enter a 4-digit numeric PIN.';
    }
  }

  static double calculateDirectDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // Earth's radius in meters (approximate)

    // Convert degrees to radians
    double lat1Rad = _degreesToRadians(lat1);
    double lon1Rad = _degreesToRadians(lon1);
    double lat2Rad = _degreesToRadians(lat2);
    double lon2Rad = _degreesToRadians(lon2);

    // Calculate differences
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Calculate distance using Haversine formula
    double a = pow(sin(dLat / 2), 2) + cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  static bool isValidName(String name) {
    RegExp namePattern = RegExp(r'^[a-zA-Z\s]+$');

    return namePattern.hasMatch(name);
  }

  static bool isValidInteger(String value) {
    final RegExp integerPattern = RegExp(r'^-?\d+$');

    return integerPattern.hasMatch(value);
  }
}
