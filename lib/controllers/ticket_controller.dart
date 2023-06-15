import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ticket.dart';
import '../services/api/url.dart';

class TicketController extends ChangeNotifier {
  Ticket? ticketDataDetail;
  TicketResponse? ticketResponse;
  TicketResponse? ticketResponseMostSales;
  List<Ticket>? ticketData;
  List<Ticket>? ticketDataMostSales;

  int? statusCodeGetTicketByIdOwner;
  int? ticketSoldOwner;
  Future<dynamic> getTicketbyIdOwner(id) async {
    print("get ticket by id owner $id");
    var url = Uri.parse(BASE_URL + GET_TICKETSOLD_OWNER(id));
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        ticketSoldOwner = data["ticket_sold"];
        print(ticketSoldOwner);
        notifyListeners();
      } else if (response.statusCode == 404) {
        statusCodeGetTicketByIdOwner = response.statusCode;
        ticketSoldOwner = 0;
        print("code: ${response.statusCode}");
        var message = data["message"];
        print(message);
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  bool anyTicket = false;

  Future<dynamic> getTicketbyIdDestination(id) async {
    print("get ticket by id destinasi $id");
    var url = Uri.parse(BASE_URL + GET_TICKET_ID(id));
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        print("code : ${response.statusCode}");
        ticketResponse = ticketFromJson(response.body);
        ticketData = ticketResponse?.ticket;
        anyTicket = true;
        notifyListeners();
      } else if (response.statusCode == 404) {
        anyTicket = false;

        print("code: ${response.statusCode}");
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
      anyTicket = false;
    }
  }

// int? mostsalesStatusCode;
  bool anySoldTicket = false;
  Future<dynamic> getMostSalesTicketByOwner(id) async {
    print("get most sales by id owner $id");

    var url = Uri.parse(BASE_URL + GET_MOSTSALES_TICKET_BYOWNER(id));
    print("URL = $url");
    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print("code : ${response.statusCode}");
        ticketResponseMostSales = ticketFromJson(response.body);
        ticketDataMostSales = ticketResponseMostSales?.ticket;
        anySoldTicket = true;
        notifyListeners();
      } else if (response.statusCode == 404) {
        anySoldTicket = false;
      } else {
        print("code: ${response.statusCode}");
        anySoldTicket = false;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
}
