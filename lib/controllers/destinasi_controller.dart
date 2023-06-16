import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/destinasi.dart';
import '../models/ticket.dart';
import '../services/api/url.dart';

class DestinasiController extends ChangeNotifier {
  DestinasiResponse? destinasiResponse;
  List<Destinasi>? destinasiData;
  List<Destinasi>? destinasiDataByOwner;
  List<Destinasi>? destinasiCategoryData;
  List<Destinasi>? destinasiQueryData;
  List<Destinasi>? destinasiDataSortIntoTen;
  List<Destinasi>? destinasiRandom;
  String messageDestinasi = "";
  Ticket? ticketDataDetail;

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

  int? destinasiByOwnerStatusCode;
  Future<dynamic> destinasiByIdOwner(id) async {
    print("ID: $id");
    var url = Uri.parse(BASE_URL + GET_DESTINASI_IDOWNER(id));
    print("URL = $url");
    try {
      var client = http.Client();
      // var response = await http.get(url);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("code: ${response.statusCode}");
        // print(data["status"]);
        destinasiByOwnerStatusCode = response.statusCode;
        destinasiResponse = destinasiFromJson(response.body);
        destinasiDataByOwner = destinasiResponse?.destinasi;
        notifyListeners();
      } else if (response.statusCode == 404) {
        destinasiByOwnerStatusCode = response.statusCode;
        destinasiQueryData!.clear();
        print(messageDestinasi);
      } else {
        destinasiByOwnerStatusCode = response.statusCode;
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

  bool isfirstpage = false;
  int? statusCodeSearch;
  Future<dynamic> searchDestinasi(String q) async {
    var url = Uri.parse(BASE_URL + GET_DESTINASI_QUERY(q));
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        isfirstpage = true;
        print(response.statusCode);
        statusCodeSearch = response.statusCode;
        destinasiResponse = destinasiFromJson(response.body);
        destinasiQueryData = destinasiResponse?.destinasi;
        notifyListeners();
      } else if (response.statusCode == 404) {
        isfirstpage = false;

        statusCodeSearch = response.statusCode;
        destinasiQueryData!.clear();
        print(statusCodeSearch);
        notifyListeners();
      } else if (response.statusCode == 400) {
        isfirstpage = false;
        statusCodeSearch = response.statusCode;
        destinasiQueryData!.clear();
        print(statusCodeSearch);
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  void clearData() {
    destinasiQueryData!.clear();
  }

  String? messageAddDestinasi;
  int? statusCodeAddDestinasi;

  int? newIdDestinasi;
  Future<dynamic> postDestinasi({
    required String? nameDestinasi,
    required int? idOwner,
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
    String? openHour,
    String? closedHour,
    // Null? image,
    required int? security,
    String? fasility,
  }) async {
    print("owner: $idOwner");
    var url = Uri.parse(BASE_URL + POST_DESTINASI);
    // print("URL = $url");
    // print("nama: $nameDestinasi");
    // print("desc: $description");
    // print("address: $address");
    // print("city: $city");
    // print("category: $category");
    // print("lat: $latitude");
    // print("long: $longitude");
    // print("openHour: $openHour");
    // print("closedHour: $closedHour");
    // print("security: $security");
    final body = {
      'name_destinasi': nameDestinasi,
      'id_owner': idOwner,
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
      'open_hour': openHour,
      'closed_hour': closedHour,
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
          'id_owner': idOwner,
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
          'open_hour': openHour,
          'closed_hour': closedHour,
          'fasility': fasility,
          'security': security,
        }),
        headers: {
          "content-type": "application/json",
        },
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print(data);

        newIdDestinasi = data["id"];
        print("ID----- $newIdDestinasi");
        statusCodeAddDestinasi = response.statusCode;
        notifyListeners();
      } else if (response.statusCode == 404) {
        messageAddDestinasi = data["message"];
        statusCodeAddDestinasi = response.statusCode;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  String? messageDeleteDestinasi;
  int? statusCodeDeleteDestinasi;
  Future<dynamic> deleteDestinasi(id) async {
    print("delete destination tourist at ID: $id");
    var url = Uri.parse(BASE_URL + DELETE_DESTINASI(id));
    print("URL = $url");
    try {
      var response = await http.delete(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        statusCodeDeleteDestinasi = response.statusCode;
        messageDeleteDestinasi = data["message"];
        print("CODE: ${response.statusCode}");
        notifyListeners();
      } else if (response.statusCode == 404) {
        print("CODE: ${response.statusCode}");
        statusCodeDeleteDestinasi = response.statusCode;
        messageDeleteDestinasi = data["message"];
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  String? messageEditDestinasi;
  int? statusCodeEditDestinasi;
  Future<dynamic> editDestinasi({
    id,
    String? nameDestinasi,
    String? description,
    String? address,
    String? city,
    String? category,
    String? contact,
    String? hobby,
    String? minutesSpend,
    double? latitude,
    double? longitude,
    String? urlMap,
    String? recWeather,
    String? openHour,
    String? closedHour,
    // Null? image,
    int? security,
    String? fasility,
  }) async {
    var url = Uri.parse(BASE_URL + PUT_DESTINASI(id));
    print(url);
    print("${hobby} and ${recWeather}");
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
      'open_hour': openHour,
      'closed_hour': closedHour,
      // 'destination_picture': image,
      'fasility': fasility,
      'security': security,
    };
    try {
      var response = await http.put(
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
          'open_hour': openHour,
          'closed_hour': closedHour,
          'fasility': fasility,
          'security': security,
        }),
        headers: {
          "content-type": "application/json",
        },
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print(data["data"]);
        statusCodeEditDestinasi = response.statusCode;
        notifyListeners();
      } else if (response.statusCode == 404) {
        messageEditDestinasi = data["message"];
        statusCodeEditDestinasi = response.statusCode;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  String? messageAddTicket;
  int? statusCodeAddTicket;
  Future<dynamic> addTicketByIdDestinasi(
      {int? idDestinasi,
      int? price,
      int? stock,
      int? ticketSold,
      String? visitDate}) async {
    var url = Uri.parse(BASE_URL + POST_TICKET);
    print(url);
    final body = {
      'id_destinasi': idDestinasi,
      'price': price,
      'stock': stock,
      'ticket_sold': ticketSold,
      'visit_date': visitDate,
    };
    try {
      var response = await http.post(
        url,
        body: json.encode(body),
        headers: {
          "content-type": "application/json",
        },
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print(data["data"]);
        statusCodeAddTicket = response.statusCode;
        notifyListeners();
      } else if (response.statusCode == 404) {
        messageAddTicket = data["message"];
        statusCodeAddTicket = response.statusCode;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  String? messageEditTicket;
  int? statusCodeEditTicket;
  Future<dynamic> editTicketByIdDestinasi({
    idDestinasi,
    int? price,
    int? stock,
  }) async {
    var url = Uri.parse(BASE_URL + PUT_TICKET(idDestinasi));
    print(url);
    final body = {
      'price': price,
      'stock': stock,
    };
    try {
      var response = await http.put(
        url,
        body: json.encode(body),
        headers: {
          "content-type": "application/json",
        },
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print(data);
        statusCodeEditTicket = response.statusCode;
        notifyListeners();
      } else if (response.statusCode == 404) {
        messageEditTicket = data["message"];
        statusCodeEditTicket = response.statusCode;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  int? statusCodeGetTicketById;
  Future<dynamic> getTicketbyIdDestination(id) async {
    print("get ticket by id destinasi");
    var url = Uri.parse(BASE_URL + GET_TICKET_ID(id));
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print("code: ${response.statusCode}");
        statusCodeGetTicketById = response.statusCode;
        var ticketData = data["data"];
        ticketDataDetail = Ticket.fromJson(ticketData);
        print(data["data"]);
        notifyListeners();
      } else if (response.statusCode == 404) {
        statusCodeGetTicketById = response.statusCode;
        print("code: ${response.statusCode}");
        var message = data["message"];
        print(message);
        // print(messageDestinasi);
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
}
