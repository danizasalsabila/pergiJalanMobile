import 'dart:convert';

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
      Ticket? ticket}) {
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
