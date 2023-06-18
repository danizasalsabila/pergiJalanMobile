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
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  String? messageAddTicket;
  int? statusCodeAddTicket;
  Future<dynamic> addTicketByIdDestinasi({
    int? idDestinasi,
    int? price,
    int? stock,
    // int? ticketSold,
    // String? visitDate
  }) async {
    var url = Uri.parse(BASE_URL + POST_TICKET);
    print(url);
    print("ID DESTINASI: $idDestinasi, PRICE: $price, STOCK: $stock");
    final body = {
      'id_destinasi': idDestinasi,
      'price': price,
      'stock': stock,
      // 'ticket_sold': ticketSold,
      // 'visit_date': visitDate,
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
        print(statusCodeAddTicket);

        notifyListeners();
      } else if (response.statusCode == 404) {
        messageAddTicket = data["message"];
        statusCodeAddTicket = response.statusCode;
        print(statusCodeAddTicket);

        notifyListeners();
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
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  String? messageDeleteTicket;
  int? statusCodeDeleteTicket;
  Future<dynamic> deleteTicket(id) async {
    print("delete destination tourist at ID: $id");
    var url = Uri.parse(BASE_URL + DELETE_TICKET(id));
    print("URL = $url");
    try {
      var response = await http.delete(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        statusCodeDeleteTicket = response.statusCode;
        messageDeleteTicket = data["message"];
        print("CODE: ${response.statusCode}");
        notifyListeners();
      } else if (response.statusCode == 404) {
        print("CODE: ${response.statusCode}");
        statusCodeDeleteTicket = response.statusCode;
        messageDeleteTicket = data["message"];
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
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
        print(ticketSoldIdDestinasi);
        notifyListeners();
      } else if (response.statusCode == 404) {
        statusCodeGetTicketByIdDestinasi = response.statusCode;
        ticketSoldIdDestinasi = 0;
        print("code: $statusCodeGetTicketByIdDestinasi");
        notifyListeners();
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
        notifyListeners();
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
        notifyListeners();
      } else {
        print("code: ${response.statusCode}");
        anySoldTicket = false;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
}
