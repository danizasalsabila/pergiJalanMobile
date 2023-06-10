import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pergijalan_mobile/models/eticket.dart';

import '../models/ticket.dart';
import '../services/api/url.dart';

class ETicketController extends ChangeNotifier {
  EticketResponse? eticketResponse;
  List<Eticket>? eticketData;
  int? totalIncomeTicket;

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
}
