import 'dart:convert';

DestinasiResponse destinasiFromJson(String str) =>
    DestinasiResponse.fromJson(json.decode(str));

String destinasiToJson(DestinasiResponse data) => json.encode(data.toJson());

class DestinasiResponse {
  String? _status;
  int? _code;
  List<Destinasi>? _destinasi;

  DestinasiResponse({String? status, int? code, List<Destinasi>? destinasi}) {
    if (status != null) {
      this._status = status;
    }
    if (code != null) {
      this._code = code;
    }
    if (destinasi != null) {
      this._destinasi = destinasi;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  int? get code => _code;
  set code(int? code) => _code = code;
  List<Destinasi>? get destinasi => _destinasi;
  set destinasi(List<Destinasi>? destinasi) => _destinasi = destinasi;

  DestinasiResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _code = json['code'];
    if (json['data'] != null) {
      _destinasi = <Destinasi>[];
      json['data'].forEach((v) {
        _destinasi!.add(new Destinasi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['code'] = this._code;
    if (this._destinasi != null) {
      data['data'] = this._destinasi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Destinasi {
  int? _id;
  String? _nameDestinasi;
  String? _description;
  String? _address;
  String? _city;
  String? _category;
  Null? _destinationPicture;
  String? _contact;
  String? _hobby;
  String? _minutesSpend;
  double? _latitude;
  double? _longitude;
  String? _urlMap;
  String? _recWeather;
  Null? _rating;
  int? _openHour;
  int? _closedHour;
  String? _createdAt;
  Null? _updatedAt;
  String? _fasility;
  int? _security;

  Destinasi({
    int? id,
    String? nameDestinasi,
    String? description,
    String? address,
    String? city,
    String? category,
    Null? destinationPicture,
    String? contact,
    String? hobby,
    String? minutesSpend,
    double? latitude,
    double? longitude,
    String? urlMap,
    String? recWeather,
    Null? rating,
    int? openHour,
    int? closedHour,
    String? createdAt,
    Null? updatedAt,
    String? fasility,
    int? security,
  }) {
    if (id != null) {
      this._id = id;
    }
    if (nameDestinasi != null) {
      this._nameDestinasi = nameDestinasi;
    }
    if (description != null) {
      this._description = description;
    }
    if (address != null) {
      this._address = address;
    }
    if (city != null) {
      this._city = city;
    }
    if (category != null) {
      this._category = category;
    }
    if (destinationPicture != null) {
      this._destinationPicture = destinationPicture;
    }
    if (contact != null) {
      this._contact = contact;
    }
    if (hobby != null) {
      this._hobby = hobby;
    }
    if (minutesSpend != null) {
      this._minutesSpend = minutesSpend;
    }
    if (latitude != null) {
      this._latitude = latitude;
    }
    if (longitude != null) {
      this._longitude = longitude;
    }
    if (urlMap != null) {
      this._urlMap = urlMap;
    }
    if (recWeather != null) {
      this._recWeather = recWeather;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (openHour != null) {
      this._openHour = openHour;
    }
    if (closedHour != null) {
      this._closedHour = closedHour;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (fasility != null) {
      this._fasility = fasility;
    }
    if (security != null) {
      this._security = security;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get nameDestinasi => _nameDestinasi;
  set nameDestinasi(String? nameDestinasi) => _nameDestinasi = nameDestinasi;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get category => _category;
  set category(String? category) => _category = category;
  Null? get destinationPicture => _destinationPicture;
  set destinationPicture(Null? destinationPicture) =>
      _destinationPicture = destinationPicture;
  String? get contact => _contact;
  set contact(String? contact) => _contact = contact;
  String? get hobby => _hobby;
  set hobby(String? hobby) => _hobby = hobby;
  String? get minutesSpend => _minutesSpend;
  set minutesSpend(String? minutesSpend) => _minutesSpend = minutesSpend;
  double? get latitude => _latitude;
  set latitude(double? latitude) => _latitude = latitude;
  double? get longitude => _longitude;
  set longitude(double? longitude) => _longitude = longitude;
  String? get urlMap => _urlMap;
  set urlMap(String? urlMap) => _urlMap = urlMap;
  String? get recWeather => _recWeather;
  set recWeather(String? recWeather) => _recWeather = recWeather;
  Null? get rating => _rating;
  set rating(Null? rating) => _rating = rating;
  int? get openHour => _openHour;
  set openHour(int? openHour) => _openHour = openHour;
  int? get closedHour => _closedHour;
  set closedHour(int? closedHour) => _closedHour = closedHour;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  Null? get updatedAt => _updatedAt;
  set updatedAt(Null? updatedAt) => _updatedAt = updatedAt;
  String? get fasility => _fasility;
  set fasility(String? fasility) => _fasility = fasility;
  int? get security => _security;
  set security(int? security) => _security = security;

  Destinasi.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nameDestinasi = json['name_destinasi'];
    _description = json['description'];
    _address = json['address'];
    _city = json['city'];
    _category = json['category'];
    _destinationPicture = json['destination_picture'];
    _contact = json['contact'];
    _hobby = json['hobby'];
    _minutesSpend = json['minutes_spend'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _urlMap = json['url_map'];
    _recWeather = json['rec_weather'];
    _rating = json['rating'];
    _openHour = json['open-hour'];
    _closedHour = json['closed-hour'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _fasility = json['fasility'];
    _security = json['security'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name_destinasi'] = this._nameDestinasi;
    data['description'] = this._description;
    data['address'] = this._address;
    data['city'] = this._city;
    data['category'] = this._category;
    data['destination_picture'] = this._destinationPicture;
    data['contact'] = this._contact;
    data['hobby'] = this._hobby;
    data['minutes_spend'] = this._minutesSpend;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['url_map'] = this._urlMap;
    data['rec_weather'] = this._recWeather;
    data['rating'] = this._rating;
    data['open-hour'] = this._openHour;
    data['closed-hour'] = this._closedHour;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['fasility'] = this._fasility;
    data['security'] = this._security;
    return data;
  }
}
