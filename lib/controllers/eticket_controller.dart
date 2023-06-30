import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pergijalan_mobile/models/eticket.dart';

import '../services/api/url.dart';

class ETicketController extends ChangeNotifier {
  EticketResponse? eticketResponse;
  List<Eticket>? eticketData;
  List<Eticket>? eticketDataUser;
  List<String> getticketSoldByIdDestinasi = [];
  // List<Eticket> eticketDataId = [];
  // List<Eticket>? eticketDataiD;
  Eticket? eticketDataiD;

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
    print("INI HARUS DI CEK $id");
    var url = Uri.parse(BASE_URL + GET_ETICKET_ID(id));
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
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  int? statusCodeGetTicketByIdDestinasi;
  int? ticketSoldIdDestinasi;
  bool isDataYear = false;
  bool isDataMonth = false;
  bool isDataWeek = false;
  Future<dynamic> getTicketSoldbyIdDestinasi(id) async {
    print("get ticket by id owner $id");
    var url = Uri.parse(BASE_URL + GET_TICKETSOLD_DESTINASI(id));
    // var url = Uri.parse(BASE_URL + GET_TICKETSOLD_DESTINASI_YEAR(id)+'2023');

    print("URL = $url");
    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        ticketSoldIdDestinasi = data["ticket_sold"];
        print("TICKET SOLD ID $id: $ticketSoldIdDestinasi");

          // listTicketSoldIdDestinasi.add(ticketSoldIdDestinasi.toString());
        // if (isDataYear == true && isDataMonth == false && isDataWeek == false) {
        //   print("ambil tahun");
        // } else if (isDataYear == false &&
        //     isDataMonth == true &&
        //     isDataWeek == false) {
        //   print("ambil bulan");

        //   listTicketSoldIdDestinasiMonth.add(ticketSoldIdDestinasi.toString());
        //   print(listTicketSoldIdDestinasiMonth);
        // } else if (isDataYear == false &&
        //     isDataMonth == false &&
        //     isDataWeek == true) {
        //   print("ambil minggu");
        // } else {
        //   print("tahun : $isDataYear");
        //   print("month : $isDataMonth");
        //   print("minggu : $isDataWeek");
        //   print("ga masuk");
        // }
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

// GET SALES BY HISTORY SALES IN A YEAR
  List<Eticket>? eticketDataOwnerByYear;
  Set<String> uniqueDestinations = Set<String>();
  Set<String> uniqueNameDestinations = Set<String>();
  List<String>? seperatedIdDestinasi;
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

  int? totalIncomeTicketByYear;
  void totalIncomeTicketsByYear(List data2) {
    int totalIncome = 0;

    for (var item in data2) {
      int price = item['price'];
      totalIncome += price;
      totalIncomeTicketByYear = totalIncome;
    }
  }

  int? ticketSoldIdDestinasiYear;
  List<String> listTicketSoldIdDestinasiYear = [];
    Future<dynamic> getTicketSoldbyIdDestinasiByYear(id, year) async {
    print("get ticket by id owner $id");
    var url = Uri.parse(BASE_URL + GET_TICKETSOLD_DESTINASI_YEAR(id)+year);
    print("URL = $url");

    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        ticketSoldIdDestinasiYear = data["ticket_sold"];
        print("TICKET SOLD ID $id: $ticketSoldIdDestinasiYear");

          listTicketSoldIdDestinasiYear.add(ticketSoldIdDestinasiYear.toString());
        notifyListeners();

      } else if (response.statusCode == 404) {
        ticketSoldIdDestinasiYear = 0;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  Future<void> getHistoryByYear(year) async {
    seperatedIdDestinasi = uniqueDestinations.toList();
    listTicketSoldIdDestinasiYear = [];

    for (String value in seperatedIdDestinasi!) {
      await getTicketSoldbyIdDestinasiByYear(value, year);
    }
  }

  // GET SALES BY HISTORY SALES IN A MONTH
  List<Eticket>? eticketDataOwnerByMonth;
  Set<String> uniqueDestinationsMonth = Set<String>();
  Set<String> uniqueNameDestinationsMonth = Set<String>();
  List<String>? seperatedIdDestinasiMonth;

//get all data by owner in a month
  Future<dynamic> allEticketByOwnerInMonth(id, year, month) async {
    print("get all eticket by $id in $year");
    var url = Uri.parse(BASE_URL + GET_ETICKET_BYOWNER_MONTH(id, year, month));
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print("code: ${response.statusCode}");

        var data2 = data["data"];
        eticketResponse = eticketFromJson(response.body);
        eticketDataOwnerByMonth = eticketResponse?.eticket;

        for (int i = 0; i < eticketDataOwnerByMonth!.length; i++) {
          uniqueDestinationsMonth
              .add(eticketDataOwnerByMonth![i].idDestinasi.toString());
          uniqueNameDestinationsMonth.add(
              eticketDataOwnerByMonth![i].destinasi!.nameDestinasi.toString());
          // countMonthDataLength = eticketDataOwnerByMonth!
          //     .where((data) => eticketDataOwnerByMonth![i]
          //         .idDestinasi
          //         .toString()
          //         .contains(data.idDestinasi.toString()))
          //     .length;
          // addcountMonthDataLength.add(countMonthDataLength!);
          // print("ID DESTINASI $uniqueDestinationsMonth : $addcountMonthDataLength");

          // print(addcountMonthDataLength);
        }

        totalIncomeTicketsByMonth(data2);
        seperatedIdDestinasiMonth!.clear();
        notifyListeners();
      } else if (response.statusCode == 404) {
        print("code: ${response.statusCode}");
        eticketDataOwnerByMonth = null;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

//count total income in a month
  int? totalIncomeTicketByMonth;
  void totalIncomeTicketsByMonth(List data2) {
    int totalIncome = 0;

    for (var item in data2) {
      int price = item['price'];
      totalIncome += price;
      totalIncomeTicketByMonth = totalIncome;
    }
  }

//get ticket sold by id destinasi in a month
  int? ticketSoldIdDestinasiMonth;
  List<String> listTicketSoldIdDestinasiMonth = [];
  Future<dynamic> getTicketSoldbyIdDestinasiByMonth(id, year, month) async {
    print("get ticket by id owner $id, in year $year and month $month");
    var url =
        Uri.parse(BASE_URL + GET_TICKETSOLD_DESTINASI_MONTH(id, year, month));
    print("URL = $url");
    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        ticketSoldIdDestinasiMonth = data["ticket_sold"];
        print("ticketSoldIdDestinasiMonth");
        print("TICKET SOLD ID $id: $ticketSoldIdDestinasiMonth");
        listTicketSoldIdDestinasiMonth
            .add(ticketSoldIdDestinasiMonth.toString());
        notifyListeners();
      } else if (response.statusCode == 404) {
        ticketSoldIdDestinasiMonth = 0;
        listTicketSoldIdDestinasiMonth = [ticketSoldIdDestinasiMonth.toString()];
        print("code: $statusCodeGetTicketByIdDestinasi");
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  Future<void> getHistoryByMonth(year, month) async {
    seperatedIdDestinasiMonth = uniqueDestinationsMonth.toList();
    listTicketSoldIdDestinasiMonth = [];

    for (String value in seperatedIdDestinasiMonth!) {
      await getTicketSoldbyIdDestinasiByMonth(value, year, month);
    }
  }



  
  // GET SALES BY HISTORY SALES IN A WEEK
  List<Eticket>? eticketDataOwnerByWeek;
  Set<String> uniqueDestinationsWeek = Set<String>();
  Set<String> uniqueNameDestinationsWeek = Set<String>();
  List<String>? seperatedIdDestinasiWeek;

//get all data by owner in a month
  Future<dynamic> allEticketByOwnerInWeek(id, date) async {
    print("get all eticket by $id in $date");
    var url = Uri.parse(BASE_URL + GET_ETICKET_BYOWNER_WEEK(id, date));
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print("code: ${response.statusCode}");

        var data2 = data["data"];
        eticketResponse = eticketFromJson(response.body);
        eticketDataOwnerByWeek = eticketResponse?.eticket;

        for (int i = 0; i < eticketDataOwnerByWeek!.length; i++) {
          uniqueDestinationsWeek
              .add(eticketDataOwnerByWeek![i].idDestinasi.toString());
          uniqueNameDestinationsWeek.add(
              eticketDataOwnerByWeek![i].destinasi!.nameDestinasi.toString());
        }

        totalIncomeTicketsByWeek(data2);
        seperatedIdDestinasiWeek!.clear();
        notifyListeners();
      } else if (response.statusCode == 404) {
        print("code: ${response.statusCode}");
        eticketDataOwnerByWeek = null;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

//count total income in a week
  int? totalIncomeTicketByWeek;
  void totalIncomeTicketsByWeek(List data2) {
    int totalIncome = 0;

    for (var item in data2) {
      int price = item['price'];
      totalIncome += price;
      totalIncomeTicketByWeek = totalIncome;
    }
  }

//get ticket sold by id destinasi in a WEEK
  int? ticketSoldIdDestinasiWeek;
  List<String> listTicketSoldIdDestinasiWeek = [];
  Future<dynamic> getTicketSoldbyIdDestinasiByWeek(id, date) async {
    print("get ticket by id owner $id, in $date");
    var url =
        Uri.parse(BASE_URL + GET_TICKETSOLD_DESTINASI_WEEK(id, date));
    print("URL = $url");
    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        ticketSoldIdDestinasiWeek = data["ticket_sold"];
        print("TICKET SOLD ID $id: $ticketSoldIdDestinasiWeek");
        listTicketSoldIdDestinasiWeek
            .add(ticketSoldIdDestinasiWeek.toString());
        notifyListeners();
      } else if (response.statusCode == 404) {
        ticketSoldIdDestinasiWeek = 0;
        listTicketSoldIdDestinasiWeek = [ticketSoldIdDestinasiWeek.toString()];
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  Future<void> getHistoryByWeek(date) async {
    seperatedIdDestinasiWeek = uniqueDestinationsWeek.toList();
    listTicketSoldIdDestinasiWeek = [];

    for (String value in seperatedIdDestinasiWeek!) {
      await getTicketSoldbyIdDestinasiByWeek(value, date);
    }
  }
}
