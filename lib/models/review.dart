import 'dart:convert';

ReviewResponse reviewResponseFromJson(String str) =>
    ReviewResponse.fromJson(json.decode(str));

String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());

class ReviewResponse {
  String? _status;
  List<Review>? _review;

  ReviewResponse({String? status, List<Review>? review}) {
    if (status != null) {
      this._status = status;
    }
    if (review != null) {
      this._review = review;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  List<Review>? get review => _review;
  set review(List<Review>? review) => _review = review;

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _review = <Review>[];
      json['data'].forEach((v) {
        _review!.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._review != null) {
      data['data'] = this._review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Review {
  int? _id;
  int? _idDestinasi;
  String? _review;
  int? _rating;
  String? _createdAt;
  String? _updatedAt;

  Review(
      {int? id,
      int? idDestinasi,
      String? review,
      int? rating,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (idDestinasi != null) {
      this._idDestinasi = idDestinasi;
    }
    if (review != null) {
      this._review = review;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get idDestinasi => _idDestinasi;
  set idDestinasi(int? idDestinasi) => _idDestinasi = idDestinasi;
  String? get review => _review;
  set review(String? review) => _review = review;
  int? get rating => _rating;
  set rating(int? rating) => _rating = rating;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Review.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _idDestinasi = json['id_destinasi'];
    _review = json['review'];
    _rating = json['rating'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['id_destinasi'] = this._idDestinasi;
    data['review'] = this._review;
    data['rating'] = this._rating;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
