class OwnerBusinessResponse {
  bool? _success;
  String? _message;
  List<OwnerBusinessUser>? _ownerBusinessUser;
  LoginOwnerUser? _loginOwnerUser;

  OwnerBusinessResponse(
      {bool? success,
      String? message,
      List<OwnerBusinessUser>? ownerBusinessUser,
      LoginOwnerUser? loginOwnerUser}) {
    if (success != null) {
      this._success = success;
    }
    if (message != null) {
      this._message = message;
    }
    if (ownerBusinessUser != null) {
      this._ownerBusinessUser = ownerBusinessUser;
    }
    if (loginOwnerUser != null) {
      this._loginOwnerUser = loginOwnerUser;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;
  List<OwnerBusinessUser>? get ownerBusinessUser => _ownerBusinessUser;
  set ownerBusinessUser(List<OwnerBusinessUser>? ownerBusinessUser) =>
      _ownerBusinessUser = ownerBusinessUser;
  LoginOwnerUser? get loginOwnerUser => _loginOwnerUser;
  set loginOwnerUser(LoginOwnerUser? loginOwnerUser) => _loginOwnerUser = loginOwnerUser;

  OwnerBusinessResponse.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _ownerBusinessUser = <OwnerBusinessUser>[];
      json['data'].forEach((v) {
        _ownerBusinessUser!.add(new OwnerBusinessUser.fromJson(v));
      });
    }
    _loginOwnerUser = json['data'] != null ? new LoginOwnerUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._ownerBusinessUser != null) {
      data['data'] = this._ownerBusinessUser!.map((v) => v.toJson()).toList();
    }
    if (this._loginOwnerUser != null) {
      data['data'] = this._loginOwnerUser!.toJson();
    }
    return data;
  }
}

class OwnerBusinessUser {
  int? _id;
  String? _namaOwner;
  String? _email;
  String? _password;
  String? _idCardNumber;
  String? _contactNumber;
  String? _address;
  String? _createdAt;
  String? _updatedAt;

  OwnerBusinessUser(
      {int? id,
      String? namaOwner,
      String? email,
      String? password,
      String? idCardNumber,
      String? contactNumber,
      String? address,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (namaOwner != null) {
      this._namaOwner = namaOwner;
    }
    if (email != null) {
      this._email = email;
    }
    if (password != null) {
      this._password = password;
    }
    if (idCardNumber != null) {
      this._idCardNumber = idCardNumber;
    }
    if (contactNumber != null) {
      this._contactNumber = contactNumber;
    }
    if (address != null) {
      this._address = address;
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
  String? get namaOwner => _namaOwner;
  set namaOwner(String? namaOwner) => _namaOwner = namaOwner;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get idCardNumber => _idCardNumber;
  set idCardNumber(String? idCardNumber) => _idCardNumber = idCardNumber;
  String? get contactNumber => _contactNumber;
  set contactNumber(String? contactNumber) => _contactNumber = contactNumber;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  OwnerBusinessUser.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _namaOwner = json['nama_owner'];
    _email = json['email'];
    _password = json['password'];
    _idCardNumber = json['id_card_number'];
    _contactNumber = json['contact_number'];
    _address = json['address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nama_owner'] = this._namaOwner;
    data['email'] = this._email;
    data['password'] = this._password;
    data['id_card_number'] = this._idCardNumber;
    data['contact_number'] = this._contactNumber;
    data['address'] = this._address;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class LoginOwnerUser {
  String? _token;
  String? _namaOwner;
  String? _email;
  int? _id;

  LoginOwnerUser({String? token, String? namaOwner, String? email, int? id}) {
    if (token != null) {
      this._token = token;
    }
    if (namaOwner != null) {
      this._namaOwner = namaOwner;
    }
    if (email != null) {
      this._email = email;
    }
    if (id != null) {
      this._id = id;
    }
  }

  String? get token => _token;
  set token(String? token) => _token = token;
  String? get namaOwner => _namaOwner;
  set namaOwner(String? namaOwner) => _namaOwner = namaOwner;
  String? get email => _email;
  set email(String? email) => _email = email;
  int? get id => _id;
  set id(int? id) => _id = id;

  LoginOwnerUser.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _namaOwner = json['nama_owner'];
    _email = json['email'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    data['name'] = this._namaOwner;
    data['email'] = this._email;
    data['id'] = this._id;
    return data;
  }
}
