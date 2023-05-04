import 'package:pergijalan_mobile/models/destinasi.dart';


class Ticket {
  int? _id;
  int? _idDestinasi;
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
