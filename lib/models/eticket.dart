import 'dart:convert';

import 'package:pergijalan_mobile/models/user.dart';

EticketResponse eticketFromJson(String str) =>
    EticketResponse.fromJson(json.decode(str));

String eticketToJson(EticketResponse data) => json.encode(data.toJson());

class EticketResponse {
  String? _status;
  String? _message;
  List<Eticket>? _eticket;

  EticketResponse({String? status, String? message, List<Eticket>? eticket}) {
    if (status != null) {
      this._status = status;
    }
    if (message != null) {
      this._message = message;
    }
    if (eticket != null) {
      this._eticket = eticket;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  String? get message => _message;
  set message(String? message) => _message = message;
  List<Eticket>? get eticket => _eticket;
  set eticket(List<Eticket>? eticket) => _eticket = eticket;

  EticketResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      eticket = <Eticket>[];
      json['data'].forEach((v) {
        eticket!.add(new Eticket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this.eticket != null) {
      data['data'] = this.eticket!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Eticket {
  int? _id;
  int? _idUser;
  int? _idOwner;
  int? _idTicket;
  int? _idDestinasi;
  String? _nameVisitor;
  String? _contactVisitor;
  String? _dateVisit;
  int? _price;
  String? _virtualAccount;
  String? _dateBook;
  String? _createdAt;
  String? _updatedAt;
  Ticket? _ticket;
  DestinasiEticket? _destinasi;
  User? _user;

  Eticket(
      {int? id,
      int? idUser,
      int? idOwner,
      int? idTicket,
      int? idDestinasi,
      String? nameVisitor,
      String? contactVisitor,
      String? dateVisit,
      int? price,
      String? virtualAccount,
      String? dateBook,
      String? createdAt,
      String? updatedAt,
      Ticket? ticket,
      User? user,
      DestinasiEticket? destinasi}) {
    if (id != null) {
      this._id = id;
    }
    if (idUser != null) {
      this._idUser = idUser;
    }
    if (idOwner != null) {
      this._idOwner = idOwner;
    }
    if (idTicket != null) {
      this._idTicket = idTicket;
    }
    if (idDestinasi != null) {
      this._idDestinasi = idDestinasi;
    }
    if (nameVisitor != null) {
      this._nameVisitor = nameVisitor;
    }
    if (contactVisitor != null) {
      this._contactVisitor = contactVisitor;
    }
    if (dateVisit != null) {
      this._dateVisit = dateVisit;
    }
    if (price != null) {
      this._price = price;
    }
    if (virtualAccount != null) {
      this._virtualAccount = virtualAccount;
    }
    if (dateBook != null) {
      this._dateBook = dateBook;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (ticket != null) {
      this._ticket = ticket;
    }
    if (destinasi != null) {
      this._destinasi = destinasi;
    }
    if (user != null) {
      this._user = user;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get idUser => _idUser;
  set idUser(int? idUser) => _idUser = idUser;
  int? get idOwner => _idOwner;
  set idOwner(int? idOwner) => _idOwner = idOwner;
  int? get idTicket => _idTicket;
  set idTicket(int? idTicket) => _idTicket = idTicket;
  int? get idDestinasi => _idDestinasi;
  set idDestinasi(int? idDestinasi) => _idDestinasi = idDestinasi;
  String? get nameVisitor => _nameVisitor;
  set nameVisitor(String? nameVisitor) => _nameVisitor = nameVisitor;
  String? get contactVisitor => _contactVisitor;
  set contactVisitor(String? contactVisitor) =>
      _contactVisitor = contactVisitor;
  String? get dateVisit => _dateVisit;
  set dateVisit(String? dateVisit) => _dateVisit = dateVisit;
  int? get price => _price;
  set price(int? price) => _price = price;
  String? get virtualAccount => _virtualAccount;
  set virtualAccount(String? virtualAccount) =>
      _virtualAccount = virtualAccount;
  String? get dateBook => _dateBook;
  set dateBook(String? dateBook) => _dateBook = dateBook;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  Ticket? get ticket => _ticket;
  set ticket(Ticket? ticket) => _ticket = ticket;
  DestinasiEticket? get destinasi => _destinasi;
  set destinasi(DestinasiEticket? destinasi) => _destinasi = destinasi;
  User? get user => _user;
  set user(User? user) => _user = user;

  Eticket.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _idUser = json['id_user'];
    _idOwner = json['id_owner'];
    _idTicket = json['id_ticket'];
    _idDestinasi = json['id_destinasi'];
    _nameVisitor = json['name_visitor'];
    _contactVisitor = json['contact_visitor'];
    _dateVisit = json['date_visit'];
    _price = json['price'];
    _virtualAccount = json['virtual_account'];
    _dateBook = json['date_book'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _ticket =
        json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
    _destinasi = json['destinasi'] != null
        ? new DestinasiEticket.fromJson(json['destinasi'])
        : null;
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['id_user'] = this._idUser;
    data['id_owner'] = this._idOwner;
    data['id_ticket'] = this._idTicket;
    data['id_destinasi'] = this._idDestinasi;
    data['name_visitor'] = this._nameVisitor;
    data['contact_visitor'] = this._contactVisitor;
    data['date_visit'] = this._dateVisit;
    data['price'] = this._price;
    data['virtual_account'] = this._virtualAccount;
    data['date_book'] = this._dateBook;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._ticket != null) {
      data['ticket'] = this._ticket!.toJson();
    }
    if (this._destinasi != null) {
      data['destinasi'] = this._destinasi!.toJson();
    }
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    return data;
  }
}

class Ticket {
  int? _id;
  int? _price;

  Ticket({int? id, int? price}) {
    if (id != null) {
      this._id = id;
    }
    if (price != null) {
      this._price = price;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get price => _price;
  set price(int? price) => _price = price;

  Ticket.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['price'] = this._price;
    return data;
  }
}

class DestinasiEticket {
  int? _id;
  String? _nameDestinasi;
  String? _address;
  String? _contact;
  String? _openHour;
  String? _closedHour;

  DestinasiEticket(
      {int? id,
      String? nameDestinasi,
      String? address,
      String? contact,
      String? openHour,
      String? closedHour}) {
    if (id != null) {
      this._id = id;
    }
    if (nameDestinasi != null) {
      this._nameDestinasi = nameDestinasi;
    }
    if (address != null) {
      this._address = address;
    }
    if (contact != null) {
      this._contact = contact;
    }
    if (openHour != null) {
      this._openHour = openHour;
    }
    if (closedHour != null) {
      this._closedHour = closedHour;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get nameDestinasi => _nameDestinasi;
  set nameDestinasi(String? nameDestinasi) => _nameDestinasi = nameDestinasi;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get contact => _contact;
  set contact(String? contact) => _contact = contact;
  String? get openHour => _openHour;
  set openHour(String? openHour) => _openHour = openHour;
  String? get closedHour => _closedHour;
  set closedHour(String? closedHour) => _closedHour = closedHour;

  DestinasiEticket.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nameDestinasi = json['name_destinasi'];
    _address = json['address'];
    _contact = json['contact'];
    _openHour = json['open_hour'];
    _closedHour = json['closed_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name_destinasi'] = this._nameDestinasi;
    data['address'] = this._address;
    data['contact'] = this._contact;
    data['open_hour'] = this._openHour;
    data['closed_hour'] = this._closedHour;
    return data;
  }
}
