import 'dart:convert';
import 'dart:io';
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
  Destinasi? destinasiDataId;
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
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  Future<dynamic> getDestinasiById(id) async {
    print("get destinasi detail by id $id");
    var url = Uri.parse(BASE_URL + GET_DESTINASI_ID(id));
    print("URL = $url");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("code: ${response.statusCode}");
        print(data["status"]);
        var data2 = data["data"];
        destinasiDataId = Destinasi.fromJson(data2);
        print("a");
        notifyListeners();
      } else if (response.statusCode == 404) {
        print("code: ${response.statusCode}");
        notifyListeners();
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
        notifyListeners();
      } else {
        destinasiByOwnerStatusCode = response.statusCode;
        notifyListeners();
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
      notifyListeners();
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
      notifyListeners();
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
        notifyListeners();
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
    File? image,
    String? urlMap,
    String? recWeather,
    String? openHour,
    String? closedHour,
    required int? security,
    String? fasility,
  }) async {
    var url = Uri.parse(BASE_URL + POST_DESTINASI);

    var request = http.MultipartRequest('POST', url);

    request.fields['name_destinasi'] = nameDestinasi!;
    request.fields['id_owner'] = idOwner.toString();
    request.fields['description'] = description!;
    request.fields['address'] = address!;
    request.fields['city'] = city!;
    request.fields['category'] = category!;
    request.fields['security'] = security.toString();
    if (contact != null) {
      request.fields['contact'] = contact;
    }
    if (hobby != null) {
      request.fields['hobby'] = hobby;
    }
    if (minutesSpend != null) {
      request.fields['minutes_spend'] = minutesSpend;
    }
    if (urlMap != null) {
      request.fields['url_map'] = urlMap;
    }
    if (recWeather != null) {
      request.fields['rec_weather'] = recWeather;
    }
    if (openHour != null) {
      request.fields['open_hour'] = openHour;
    }
    if (closedHour != null) {
      request.fields['closed_hour'] = closedHour;
    }
    if (fasility != null) {
      request.fields['fasility'] = fasility;
    }

    if (image != null) {
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'destination_picture',
        stream,
        length,
        filename: image.path,
      );
      request.files.add(multipartFile);
    }

    try {
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = utf8.decode(responseData);

      var data = json.decode(responseString);
      if (response.statusCode == 200) {
        print(data);
        statusCodeAddDestinasi = response.statusCode;
        print(statusCodeAddDestinasi);
        messageAddDestinasi = data['message'];
        newIdDestinasi = data["id"];
        print("ID----- $newIdDestinasi");
      } else if (response.statusCode == 404) {
        statusCodeAddDestinasi = response.statusCode;
        print(statusCodeAddDestinasi);

        messageAddDestinasi = data['message'];

        print(messageAddDestinasi);
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
  // Future<dynamic> postDestinasi({
  //   required String? nameDestinasi,
  //   required int? idOwner,
  //   required String? description,
  //   required String? address,
  //   required String? city,
  //   required String? category,
  //   String? contact,
  //   String? hobby,
  //   String? minutesSpend,
  //   // double? latitude,
  //   File? image,
  //   // double? longitude,
  //   String? urlMap,
  //   String? recWeather,
  //   String? openHour,
  //   String? closedHour,
  //   // String? image,
  //   required int? security,
  //   String? fasility,
  // }) async {
  //   print("owner: $idOwner");
  //   var url = Uri.parse(BASE_URL + POST_DESTINASI);
  //   // print("URL = $url");
  //   // print("nama: $nameDestinasi");
  //   // print("desc: $description");
  //   // print("address: $address");
  //   // print("city: $city");
  //   // print("category: $category");
  //   // print("lat: $latitude");
  //   // print("long: $longitude");
  //   // print("openHour: $openHour");
  //   // print("closedHour: $closedHour");
  //   // print("security: $security");
  //   final body = {
  //     'name_destinasi': nameDestinasi,
  //     'id_owner': idOwner,
  //     'description': description,
  //     'address': address,
  //     'city': city,
  //     'destination_picture': image,
  //     'category': category,
  //     'contact': contact,
  //     'hobby': hobby,
  //     'minutes_spend': minutesSpend,
  //     // 'latitude': latitude,
  //     // 'longitude': longitude,
  //     'url_map': urlMap,
  //     'rec_weather': recWeather,
  //     'open_hour': openHour,
  //     'closed_hour': closedHour,
  //     // 'destination_picture': image,
  //     'fasility': fasility,
  //     'security': security,
  //   };
  //   try {
  //     var response = await http.post(
  //     // var response = await http.post(
  //       url,
  //       body: json.encode({
  //         'name_destinasi': nameDestinasi,
  //         'description': description,
  //         'id_owner': idOwner,
  //         'address': address,
  //         'city': city,
  //         'category': category,
  //         'contact': contact,
  //         'hobby': hobby,
  //         'destination_picture': image,
  //         'minutes_spend': minutesSpend,
  //         // 'latitude': latitude,
  //         // 'longitude': longitude,
  //         'url_map': urlMap,
  //         'rec_weather': recWeather,
  //         'open_hour': openHour,
  //         'closed_hour': closedHour,
  //         'fasility': fasility,
  //         'security': security,
  //       }),
  //       headers: {
  //         "content-type": "application/json",
  //       },
  //     );
  //     var data = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       print(data);

  //       newIdDestinasi = data["id"];
  //       print("ID----- $newIdDestinasi");
  //       statusCodeAddDestinasi = response.statusCode;
  //       notifyListeners();
  //     } else if (response.statusCode == 404) {
  //       messageAddDestinasi = data["message"];
  //       statusCodeAddDestinasi = response.statusCode;
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print("ERROR MESSAGE: $e");
  //   }
  // }

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
        notifyListeners();
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
    // String? imagePrev,
    // double? latitude,
    // double? longitude,
    String? urlMap,
    String? recWeather,
    String? openHour,
    String? closedHour,
    File? image,
    int? security,
    String? fasility,
  }) async {
    var url = Uri.parse(BASE_URL + PUT_DESTINASI(id.toString()));
    print(url);
    print("${hobby} and ${recWeather}");

    try {
      var request = http.MultipartRequest('POST', url);

      if (image != null) {
        print("kirim image baru");
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = http.MultipartFile(
          'destination_picture',
          stream,
          length,
          filename: image.path,
        );
        request.files.add(multipartFile);
      } else {
        print("image yang dikirim pakai image lama");
        request.fields['destination_picture'] = "";
      }
      // else {
      //   if (imagePrev != null) {
      //     //   print("pakai image lama");
      //     //     var multipartFile = await http.MultipartFile.fromPath(
      //     //   'destination_picture',
      //     //   imagePrev,
      //     // );
      //     // request.files.add(multipartFile);
      //     var previousImage = File(imagePrev);
      //     var stream = http.ByteStream(previousImage.openRead());
      //     var length = await previousImage.length();
      //     var multipartFile = http.MultipartFile(
      //       'destination_picture',
      //       stream,
      //       length,
      //       filename: previousImage.path,
      //     );
      //     request.files.add(multipartFile);

      //     // request.fields['destination_picture'] = imagePrev;
      //     // print(imagePrev);

      //     // var previousImage = File(imagePrev);
      //     // print(previousImage);
      //     // var stream = http.ByteStream(previousImage.openRead());
      //     // var length = await previousImage.length();
      //     // print(length);

      //     // var multipartFile = http.MultipartFile(
      //     //   'destination_picture',
      //     //   stream,
      //     //   length,
      //     //   filename: previousImage.path,
      //     // );
      //     // request.files.add(multipartFile);
      //   }
      // }

      request.fields['name_destinasi'] = nameDestinasi ?? '';
      request.fields['description'] = description ?? '';
      request.fields['address'] = address ?? '';
      request.fields['city'] = city ?? '';
      request.fields['category'] = category ?? '';
      request.fields['contact'] = contact ?? '';
      request.fields['hobby'] = hobby ?? '';
      request.fields['minutes_spend'] = minutesSpend ?? '';
      // request.fields['latitude'] = latitude?.toString() ?? '';
      // request.fields['longitude'] = longitude?.toString() ?? '';
      request.fields['url_map'] = urlMap ?? '';
      request.fields['rec_weather'] = recWeather ?? '';
      request.fields['open_hour'] = openHour ?? '';
      request.fields['closed_hour'] = closedHour ?? '';
      request.fields['fasility'] = fasility ?? '';
      request.fields['_method'] = 'put';
      request.fields['security'] = security?.toString() ?? '';

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = utf8.decode(responseData);

      if (response.statusCode == 200) {
        var data = json.decode(responseString);
        print(data["data"]);

        statusCodeEditDestinasi = response.statusCode;
        notifyListeners();
      } else if (response.statusCode == 404) {
        var data = json.decode(responseString);
        messageEditDestinasi = data["message"];

        statusCodeEditDestinasi = response.statusCode;
        notifyListeners();
      } else {
        var data = json.decode(responseString);
        messageEditDestinasi = data["message"];

        statusCodeEditDestinasi = response.statusCode;
        print(statusCodeEditDestinasi);
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
  // Future<dynamic> editDestinasi({
  //   id,
  //   String? nameDestinasi,
  //   String? description,
  //   String? address,
  //   String? city,
  //   String? category,
  //   String? contact,
  //   String? hobby,
  //   String? minutesSpend,
  //   // double? latitude,
  //   // double? longitude,
  //   String? urlMap,
  //   String? recWeather,
  //   String? openHour,
  //   String? closedHour,
  //   File? image,
  //   int? security,
  //   String? fasility,
  // }) async {
  //   var url = Uri.parse(BASE_URL + PUT_DESTINASI(id));
  //   print(url);
  //   print("${hobby} and ${recWeather}");
  //   try {
  //     var response = await http.put(
  //       url,
  //       body: json.encode({
  //         'name_destinasi': nameDestinasi,
  //         'description': description,
  //         'address': address,
  //         'city': city,
  //         'category': category,
  //         'contact': contact,
  //         'hobby': hobby,
  //         'destination_picture' :image,
  //         'minutes_spend': minutesSpend,
  //         // 'latitude': latitude,
  //         // 'longitude': longitude,
  //         'url_map': urlMap,
  //         'rec_weather': recWeather,
  //         'open_hour': openHour,
  //         'closed_hour': closedHour,
  //         'fasility': fasility,
  //         'security': security,
  //       }),
  //       headers: {
  //         "content-type": "application/json",
  //       },
  //     );
  //     var data = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       print(data["data"]);
  //       statusCodeEditDestinasi = response.statusCode;
  //       notifyListeners();
  //     } else if (response.statusCode == 404) {
  //       messageEditDestinasi = data["message"];
  //       statusCodeEditDestinasi = response.statusCode;
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print("ERROR MESSAGE: $e");
  //   }
  // }

  // int? statusCodeGetTicketById;
  // Future<dynamic> getTicketbyIdDestination(id) async {
  //   print("get ticket by id destinasi");
  //   var url = Uri.parse(BASE_URL + GET_TICKET_ID(id));
  //   print("URL = $url");
  //   try {
  //     var response = await http.get(url);

  //     var data = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       print("code: ${response.statusCode}");
  //       statusCodeGetTicketById = response.statusCode;
  //       var ticketData = data["data"];
  //       ticketDataDetail = Ticket.fromJson(ticketData);
  //       print(data["data"]);
  //       notifyListeners();
  //     } else if (response.statusCode == 404) {
  //       statusCodeGetTicketById = response.statusCode;
  //       print("code: ${response.statusCode}");
  //       var message = data["message"];
  //       print(message);
  //       // print(messageDestinasi);
  //     }
  //   } catch (e) {
  //     print("ERROR MESSAGE: $e");
  //   }
  // }
}
