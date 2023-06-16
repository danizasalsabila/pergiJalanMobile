import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pergijalan_mobile/models/eticket.dart';

import '../models/ticket.dart';
import '../services/api/url.dart';

class ETicketController extends ChangeNotifier {
  EticketResponse? eticketResponse;
  List<Eticket>? eticketData;
  List<Eticket>? eticketDataUser;
  List<Eticket>? eticketDataOwnerByYear;
  List<String> getticketSoldByIdDestinasi = [];
  List<Eticket>? eticketDataOwnerByWeek;
  List<Eticket>? eticketDataOwnerByMonth;
  List<Eticket> eticketDataId = [];
  // List<Eticket>? eticketDataiD;
  Eticket? eticketDataiD;

  int? totalIncomeTicket;
  int? totalIncomeTicketByYear;

  Future<dynamic> allEticketByOwner(id) async {
    print("get all data eticket by $id");
    var url = Uri.parse(BASE_URL + GET_ETICKET_OWNER(id));
    print("URL = $url");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("code: ${response.statusCode}");
        print(data["status"]);

        eticketResponse = eticketFromJson(response.body);
        eticketData = eticketResponse?.eticket;

        print("a");
        var data2 = data["data"];
        totalIncomeTickets(data2);
        print("b");

        notifyListeners();
      } else if (response.statusCode == 404) {
        print("code: ${response.statusCode}");
        eticketData = null;
        totalIncomeTicket = 0;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  void totalIncomeTickets(List data2) {
    int totalIncome = 0;

    for (var item in data2) {
      int price = item['price'];
      totalIncome += price;
      totalIncomeTicket = totalIncome;
      // print(totalIncomeTicket);
    }
  }

  Future<dynamic> allEticketByUser(id) async {
    print("get all data user eticket by $id");
    var url = Uri.parse(BASE_URL + GET_ETICKET_USER(id));
    print("URL = $url");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("code: ${response.statusCode}");
        print(data["status"]);

        eticketResponse = eticketFromJson(response.body);
        eticketDataUser = eticketResponse?.eticket;

        notifyListeners();
      } else if (response.statusCode == 404) {
        print("code: ${response.statusCode}");
        eticketDataUser = null;
        // totalIncomeTicket = 0;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  // int? _totalTrx;
  // void totalIncomeTicket(List totalTransactionsTicket) {
  //   var sum = 0;
  //   if (totalTransactionsTicket.isNotEmpty) {
  //     for (int total in totalTransactionsTicket) {
  //       sum += total;
  //       _totalTrx = sum;
  //       print(_totalTrx);
  //       notifyListeners();
  //     }
  //   } else {
  //     print("no card/transaction");
  //   }
  // }

  String? messageAddEticket;
  int? statusCodeAddEticket;
  int? idAddETicket;
  Future<dynamic> postEticket({
    required int? idUser,
    required int? idTicket,
    required int? idDestinasi,
    required int? idOwner,
    required String? nameVisitor,
    required String? contactVisitor,
    required String? dateVisit,
  }) async {
    var url = Uri.parse(BASE_URL + POST_ETICKET);
    final body = {
      'id_user': idUser,
      'id_ticket': idTicket,
      'id_destinasi': idDestinasi,
      'id_owner': idOwner,
      'name_visitor': nameVisitor,
      'contact_visitor': contactVisitor,
      'date_visit': dateVisit,
    };
    print(body);
    print(url);
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
        print(data);
        idAddETicket = data["data"]["id"];
        print(idAddETicket);
        statusCodeAddEticket = response.statusCode;
        print(statusCodeAddEticket);
        notifyListeners();
      } else if (response.statusCode == 404) {
        messageAddEticket = data["message"];
        statusCodeAddEticket = response.statusCode;
        print(statusCodeAddEticket);

        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  Future<dynamic> eticketById(id) async {
    print("get all data eticket by $id");
    var url = Uri.parse(BASE_URL + GET_ETICKET_OWNER(id));
    print("URL = $url");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("code: ${response.statusCode}");
        print(data["status"]);
        var data2 = data["data"][0];
        eticketDataiD = Eticket.fromJson(data2);
        print("a");
        notifyListeners();
      } else if (response.statusCode == 404) {
        print("code: ${response.statusCode}");
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  Set<String> uniqueDestinations = Set<String>();
  Set<String> uniqueNameDestinations = Set<String>();
  Future<dynamic> allEticketByOwnerInYear(id, year) async {
    print("get all eticket by $id in $year");
    var url = Uri.parse(BASE_URL + GET_ETICKET_BYOWNER_LASTYEAR(id) + year);
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print("code: ${response.statusCode}");

        var data2 = data["data"];
        totalIncomeTickets(data2);
        eticketResponse = eticketFromJson(response.body);
        eticketDataOwnerByYear = eticketResponse?.eticket;

        for (int i = 0; i < eticketDataOwnerByYear!.length; i++) {
          uniqueDestinations
              .add(eticketDataOwnerByYear![i].idDestinasi.toString());
          uniqueNameDestinations.add(
              eticketDataOwnerByYear![i].destinasi!.nameDestinasi.toString());
        }
        totalIncomeTicketsByYear(data2);

        seperatedIdDestinasi!.clear();
        notifyListeners();
      } else if (response.statusCode == 404) {
        print("code: ${response.statusCode}");
        eticketDataOwnerByYear = null;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  void totalIncomeTicketsByYear(List data2) {
    int totalIncome = 0;

    for (var item in data2) {
      int price = item['price'];
      totalIncome += price;
      totalIncomeTicketByYear = totalIncome;
      // print(totalIncomeTicket);
    }
  }

  int? statusCodeGetTicketByIdDestinasi;
  int? ticketSoldIdDestinasi;
  Future<dynamic> getTicketSoldbyIdDestinasi(id) async {
    print("get ticket by id owner $id");
    var url = Uri.parse(BASE_URL + GET_TICKETSOLD_DESTINASI(id));
    print("URL = $url");
    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        ticketSoldIdDestinasi = data["ticket_sold"];
        print("TICKET SOLD ID $id: $ticketSoldIdDestinasi");
        listTicketSoldIdDestinasi!.add(ticketSoldIdDestinasi.toString());
        notifyListeners();
      } else if (response.statusCode == 404) {
        statusCodeGetTicketByIdDestinasi = response.statusCode;
        ticketSoldIdDestinasi = 0;
        print("code: $statusCodeGetTicketByIdDestinasi");
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  // for (int i = 0; i < eticketDataOwnerByYear!.length; i++) {
  //   uniqueDestinations
  //       .add(eticketDataOwnerByYear![i].idDestinasi.toString());
  //   uniqueNameDestinations
  //       .add(eticketDataOwnerByYear![i].idDestinasi.toString());
  // }

  // Set<String> uniqueNameDestinations = Set<String>();
  List<String>? seperatedIdDestinasi;

  List<String>? listTicketSoldIdDestinasi;
  Future<void> getHistoryByYear() async {
    seperatedIdDestinasi = uniqueDestinations.toList();
    listTicketSoldIdDestinasi = [];

    for (String value in seperatedIdDestinasi!) {
      await getTicketSoldbyIdDestinasi(value);
    }

    print("data data ticket sold: $listTicketSoldIdDestinasi");
  }

  // void getHistoryByYear() async {
  //   seperatedIdDestinasi = uniqueDestinations.toList();
  //   listTicketSoldIdDestinasi = [];

  //   for (String value in seperatedIdDestinasi!) {
  //     // print(value);
  //     await getTicketSoldbyIdDestinasi(value);
  //   }

  // for (int i = 0; i < getticketSoldByIdDestinasi.length; i++) {
  //   listTicketSoldIdDestinasi!.add(ticketSoldIdDestinasi.toString());
  // }

  // print("data data ticket sold: $listTicketSoldIdDestinasi");

  // }
}
