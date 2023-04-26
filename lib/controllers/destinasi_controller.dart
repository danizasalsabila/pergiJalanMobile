import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pergijalan_mobile/models/review.dart';

import '../models/destinasi.dart';
import '../services/api/url.dart';

class DestinasiController extends ChangeNotifier {
  DestinasiResponse? destinasiResponse;
  List<Destinasi>? destinasiData;
  List<Destinasi>? destinasiCategoryData;
  List<Destinasi>? destinasiQueryData;
  List<Destinasi>? destinasiDataSortIntoTen;
  List<Destinasi>? destinasiRandom;
  String messageDestinasi = "";

  // String dataDestinasi = "";

  Future<dynamic> allDestinasi() async {
    print("get all data destinasi");
    var url = Uri.parse(BASE_URL + GET_DESTINASI);
    print("URL = $url");
    try {
      var client = http.Client();
      // var response = await http.get(url);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("code: ${response.statusCode}");
        print(data["status"]);
        // messageDestinasi = data["status"];
        // var dataDestinasi = data["data"];
        // print(messageDestinasi);
        // print(dataDestinasi);

        destinasiResponse = destinasiFromJson(response.body);
        destinasiData = destinasiResponse?.destinasi;
        notifyListeners();
      } else if (response.statusCode == 404) {
        print(messageDestinasi);
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  setTenData() {
    if (destinasiData!.length <= 10) {
      destinasiDataSortIntoTen = destinasiData;
      notifyListeners();
    } else {
      print("destinasi sorting into 10 data");
      destinasiDataSortIntoTen = destinasiData?.sublist(0, 10);
    }
  }

  final randomList = Random();
  setRandomDestinasi() {
    if (destinasiData!.length <= 6) {
      destinasiRandom = destinasiData;
      notifyListeners();
    } else {
      print("data sort into 6 random list of destinasi");
      destinasiRandom = List.generate(6,
          (index) => destinasiData![randomList.nextInt(destinasiData!.length)]);
    }
  }

  Future<dynamic> destinasiCategory(String q) async {
    print("get data by category");
    var url = Uri.parse(BASE_URL + GET_DESTINASI_CATEGORY(q));
    print("URL = $url");
    try {
      var client = http.Client();
      // var response = await http.get(url);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("code: ${response.statusCode}");
        print(data["message"]);
        destinasiResponse = destinasiFromJson(response.body);
        destinasiCategoryData = destinasiResponse?.destinasi;
        notifyListeners();
      } else if (response.statusCode == 404) {
        print(messageDestinasi);
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  Future<dynamic> searchDestinasi(String q) async {
    print("get data by $q category");
    var url = Uri.parse(BASE_URL + GET_DESTINASI_QUERY(q));
    print("URL = $url");
    try {
      var client = http.Client();
      // var response = await http.get(url);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("code: ${response.statusCode}");
        print(data["message"]);
        destinasiResponse = destinasiFromJson(response.body);
        destinasiQueryData = destinasiResponse?.destinasi;
        notifyListeners();
      } else if (response.statusCode == 404) {
        print(messageDestinasi);
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  String? messageAddDestinasi;
  int? statusCodeAddDestinasi;
  Future<dynamic> postDestinasi({
    required String? nameDestinasi,
    required String? description,
    required String? address,
    required String? city,
    required String? category,
    String? contact,
    String? hobby,
    String? minutesSpend,
    double? latitude,
    double? longitude,
    String? urlMap,
    String? recWeather,
    int? openHour,
    int? closedHour,
    // Null? image,
    required int? security,
    String? fasility,
  }) async {
    var url = Uri.parse(BASE_URL + POST_DESTINASI);
    print("URL = $url");
    print("nama: $nameDestinasi");
    print("desc: $description");
    print("address: $address");
    print("city: $city");
    print("category: $category");
    print("lat: $latitude");
    print("long: $longitude");
    print("openHour: $openHour");
    print("closedHour: $closedHour");
    print("security: $security");
    final body = {
      'name_destinasi': nameDestinasi,
      'description': description,
      'address': address,
      'city': city,
      'category': category,
      'contact': contact,
      'hobby': hobby,
      'minutes_spend': minutesSpend,
      'latitude': latitude,
      'longitude': longitude,
      'url_map': urlMap,
      'rec_weather': recWeather,
      'open-hour': openHour,
      'closed-hour': closedHour,
      // 'destination_picture': image,
      'fasility': fasility,
      'security': security,
    };
    try {
      var response = await http.post(
        url,
        body: json.encode({
          'name_destinasi': nameDestinasi,
          'description': description,
          'address': address,
          'city': city,
          'category': category,
          'contact': contact,
          'hobby': hobby,
          'minutes_spend': minutesSpend,
          'latitude': latitude,
          'longitude': longitude,
          'url_map': urlMap,
          'rec_weather': recWeather,
          'open-hour': openHour,
          'closed-hour': closedHour,
          'fasility': fasility,
          'security': security,
        }),
        headers: {
          "content-type": "application/json",
        },
      );

      // print('CODE: ${response.statusCode}');
      // print(response.headers);
      // print(response.request);
      // print("``````````````````````````````````````");
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print(data["message"]);
        statusCodeAddDestinasi = response.statusCode;
        // destinasiResponse = destinasiFromJson(response.body);
        // destinasiQueryData = destinasiResponse?.destinasi;
        notifyListeners();
      } else if (response.statusCode == 404) {
        print(messageAddDestinasi);
        messageAddDestinasi = data["message"];
        statusCodeAddDestinasi = response.statusCode;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
}
