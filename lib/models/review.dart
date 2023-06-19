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
  int? _idUser;
  String? _review;
  int? _rating;
  String? _createdAt;
  String? _updatedAt;
  Destinasi? _destinasi;
	User? _user;

  Review(
      {int? id,
      int? idDestinasi,
      int? idUser,
      String? review,
      int? rating,
      String? createdAt,
      String? updatedAt,
      Destinasi? destinasi,
      User? user
      }) {
    if (id != null) {
      this._id = id;
    }
    if (idDestinasi != null) {
      this._idDestinasi = idDestinasi;
    }
    if (idUser != null) {
      this._idUser = idUser;
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
    } if (destinasi != null) {
      this._destinasi = destinasi;
    }
    if (user != null) {
this._user = user;
}
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get idDestinasi => _idDestinasi;
  set idDestinasi(int? idDestinasi) => _idDestinasi = idDestinasi;
  int? get idUser => _idUser;
  set idUser(int? idUser) => _idUser = idUser;
  String? get review => _review;
  set review(String? review) => _review = review;
  int? get rating => _rating;
  set rating(int? rating) => _rating = rating;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  Destinasi? get destinasi => _destinasi;
  set destinasi(Destinasi? destinasi) => _destinasi = destinasi;
  User? get user => _user;
	set user(User? user) => _user = user;

  Review.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _idDestinasi = json['id_destinasi'];
    _idUser = json['id_user'];
    _review = json['review'];
    _rating = json['rating'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _destinasi = json['destinasi'] != null
        ? new Destinasi.fromJson(json['destinasi'])
        : null;
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this._id;
		data['id_destinasi'] = this._idDestinasi;
		data['id_user'] = this._idUser;
		data['review'] = this._review;
		data['rating'] = this._rating;
		data['created_at'] = this._createdAt;
		data['updated_at'] = this._updatedAt;
    if (this._destinasi != null) {
      data['destinasi'] = this._destinasi!.toJson();
    }
		if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
		return data;
	}
}

class Destinasi {
  int? _id;
  int? _idOwner;
  String? _nameDestinasi;

  Destinasi({int? id, int? idOwner, String? nameDestinasi}) {
    if (id != null) {
      this._id = id;
    }
    if (idOwner != null) {
      this._idOwner = idOwner;
    }
    if (nameDestinasi != null) {
      this._nameDestinasi = nameDestinasi;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get idOwner => _idOwner;
  set idOwner(int? idOwner) => _idOwner = idOwner;
  String? get nameDestinasi => _nameDestinasi;
  set nameDestinasi(String? nameDestinasi) => _nameDestinasi = nameDestinasi;

  Destinasi.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _idOwner = json['id_owner'];
    _nameDestinasi = json['name_destinasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['id_owner'] = this._idOwner;
    data['name_destinasi'] = this._nameDestinasi;
    return data;
  }
}

class User {
  int? _id;
  String? _name;
  String? _email;

  User({int? id, String? name, String? email}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    return data;
  }
}