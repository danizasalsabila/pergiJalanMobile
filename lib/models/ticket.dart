import 'dart:convert';

import 'package:pergijalan_mobile/models/destinasi.dart';


TicketResponse ticketFromJson(String str) =>
    TicketResponse.fromJson(json.decode(str));

String ticketToJson(TicketResponse data) => json.encode(data.toJson());


class TicketResponse {
  String? _status;
  List<Ticket>? _ticket;

  TicketResponse({String? status, List<Ticket>? ticket}) {
    if (status != null) {
      this._status = status;
    }
    if (ticket != null) {
      this._ticket = ticket;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  List<Ticket>? get ticket => _ticket;
  set ticket(List<Ticket>? ticket) => _ticket = ticket;

  TicketResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _ticket = <Ticket>[];
      json['data'].forEach((v) {
        _ticket!.add(new Ticket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._ticket != null) {
      data['data'] = this._ticket!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ticket {
  int? _id;
  int? _idDestinasi;
  String? _nameTicket;
  int? _price;
  int? _stock;
  int? _ticketSold;
  String? _visitDate;
  String? _createdAt;
  String? _updatedAt;
  Destinasi? _destinasi;

  Ticket(
      {int? id,
      int? idDestinasi,
      String? nameTicket,
      int? price,
      int? stock,
      int? ticketSold,
      String? visitDate,
      String? createdAt,
      String? updatedAt,
      Destinasi? destinasi}) {
    if (id != null) {
      this._id = id;
    }
    if (idDestinasi != null) {
      this._idDestinasi = idDestinasi;
    }
    if (nameTicket != null) {
      this._nameTicket = nameTicket;
    }
    if (price != null) {
      this._price = price;
    }
    if (stock != null) {
      this._stock = stock;
    }
    if (ticketSold != null) {
      this._ticketSold = ticketSold;
    }
    if (visitDate != null) {
      this._visitDate = visitDate;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (destinasi != null) {
      this._destinasi = destinasi;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get idDestinasi => _idDestinasi;
  set idDestinasi(int? idDestinasi) => _idDestinasi = idDestinasi;
  String? get nameTicket => _nameTicket;
  set nameTicket(String? nameTicket) => _nameTicket = nameTicket;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get stock => _stock;
  set stock(int? stock) => _stock = stock;
  int? get ticketSold => _ticketSold;
  set ticketSold(int? ticketSold) => _ticketSold = ticketSold;
  String? get visitDate => _visitDate;
  set visitDate(String? visitDate) => _visitDate = visitDate;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  Destinasi? get destinasi => _destinasi;
  set destinasi(Destinasi? destinasi) => _destinasi = destinasi;

  Ticket.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _idDestinasi = json['id_destinasi'];
    _nameTicket = json['name_ticket'];
    _price = json['price'];
    _stock = json['stock'];
    _ticketSold = json['ticket_sold'];
    _visitDate = json['visit_date'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _destinasi = json['destinasi'] != null
        ? new Destinasi.fromJson(json['destinasi'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['id_destinasi'] = this._idDestinasi;
    data['name_ticket'] = this._nameTicket;
    data['price'] = this._price;
    data['stock'] = this._stock;
    data['ticket_sold'] = this._ticketSold;
    data['visit_date'] = this._visitDate;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._destinasi != null) {
      data['destinasi'] = this._destinasi!.toJson();
    }
    return data;
  }
}



// class AddTicket {
//   int? _id;
//   int? _idDestinasi;
//   int? _price;
//   int? _stock;
//   int? _ticketSold;
//   String? _visitDate;
//   String? _createdAt;
//   String? _updatedAt;
//   Destinasi? _destinasi;

//   AddTicket(
//       {int? id,
//       int? idDestinasi,
//       int? price,
//       int? stock,
//       int? ticketSold,
//       String? visitDate,
//       String? createdAt,
//       String? updatedAt,
//       Destinasi? destinasi}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (idDestinasi != null) {
//       this._idDestinasi = idDestinasi;
//     }
//     if (price != null) {
//       this._price = price;
//     }
//     if (stock != null) {
//       this._stock = stock;
//     }
//     if (ticketSold != null) {
//       this._ticketSold = ticketSold;
//     }
//     if (visitDate != null) {
//       this._visitDate = visitDate;
//     }
//     if (createdAt != null) {
//       this._createdAt = createdAt;
//     }
//     if (updatedAt != null) {
//       this._updatedAt = updatedAt;
//     }
//     if (destinasi != null) {
//       this._destinasi = destinasi;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   int? get idDestinasi => _idDestinasi;
//   set idDestinasi(int? idDestinasi) => _idDestinasi = idDestinasi;
//   int? get price => _price;
//   set price(int? price) => _price = price;
//   int? get stock => _stock;
//   set stock(int? stock) => _stock = stock;
//   int? get ticketSold => _ticketSold;
//   set ticketSold(int? ticketSold) => _ticketSold = ticketSold;
//   String? get visitDate => _visitDate;
//   set visitDate(String? visitDate) => _visitDate = visitDate;
//   String? get createdAt => _createdAt;
//   set createdAt(String? createdAt) => _createdAt = createdAt;
//   String? get updatedAt => _updatedAt;
//   set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
//   Destinasi? get destinasi => _destinasi;
//   set destinasi(Destinasi? destinasi) => _destinasi = destinasi;

//   AddTicket.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _idDestinasi = json['id_destinasi'];
//     _price = json['price'];
//     _stock = json['stock'];
//     _ticketSold = json['ticket_sold'];
//     _visitDate = json['visit_date'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     _destinasi = json['destinasi'] != null
//         ? new Destinasi.fromJson(json['destinasi'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['id_destinasi'] = this._idDestinasi;
//     data['price'] = this._price;
//     data['stock'] = this._stock;
//     data['ticket_sold'] = this._ticketSold;
//     data['visit_date'] = this._visitDate;
//     data['created_at'] = this._createdAt;
//     data['updated_at'] = this._updatedAt;
//     if (this._destinasi != null) {
//       data['destinasi'] = this._destinasi!.toJson();
//     }
//     return data;
//   }
// }
