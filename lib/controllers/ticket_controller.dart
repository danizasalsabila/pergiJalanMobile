import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/ticket.dart';
import '../services/api/url.dart';

class TicketController extends ChangeNotifier{
  Ticket? ticketDataDetail;

  
  
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
}