class UserResponse {
  bool? _status;
  bool? _success;
  String? _message;
  String? _error;
  int? _code;
  // Register? _register;
  Login? _login;
  List<AllUser>? _allUser;
  User? _user;

  UserResponse({
    bool? success,
    bool? status,
    String? message,
    String? error,
    int? code,
    Register? register,
    Login? login,
    List<AllUser>? allUser,
    User? user,
  }) {
    if (success != null) {
      this._success = success;
    }
    if (status != null) {
      this._status = status;
    }
    if (message != null) {
      this._message = message;
    }
    if (error != null) {
      this._error = error;
    }
    if (code != null) {
      this._code = code;
    }
    // if (register != null) {
    //   this._register = register;
    // }
    if (login != null) {
      this._login = login;
    }
    if (allUser != null) {
      this._allUser = allUser;
    }
    if (user != null) {
      this._user = user;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  bool? get status => _status;
  set status(bool? status) => _status = status;
  String? get message => _message;
  set message(String? message) => _message = message;
  String? get error => _error;
  set error(String? error) => _error = error;
  int? get code => _code;
  set code(int? code) => _code = code;
  // Register? get register=> _register;
  // set register(Register? register) => _register = register;
  Login? get login => _login;
  set login(Login? login) => _login = login;
  List<AllUser>? get allUser => _allUser;
  set allUser(List<AllUser>? allUser) => _allUser = allUser;
  User? get user => _user;
  set user(User? user) => _user = user;

  UserResponse.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _error = json['error'];
    _code = json['code'];
    // _register = json['data'] != null ? new Register.fromJson(json['data']) : null;
    _login = json['data'] != null ? new Login.fromJson(json['data']) : null;
    _user = json['data'] != null ? new User.fromJson(json['data']) : null;
    if (json['data'] != null) {
      _allUser = <AllUser>[];
      json['data'].forEach((v) {
        _allUser!.add(new AllUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['status'] = this._status;
    data['message'] = this._message;
    data['error'] = this._error;
    data['code'] = this._code;
    // if (this._register != null) {
    //   data['data'] = this._register!.toJson();
    // }
    if (this._login != null) {
      data['data'] = this._login!.toJson();
    }
    if (this._allUser != null) {
      data['data'] = this._allUser!.map((v) => v.toJson()).toList();
    }
    if (this._user != null) {
      data['data'] = this._user!.toJson();
    }
    return data;
  }
}

class Register {
  String? _name;

  Data({String? name}) {
    if (name != null) {
      this._name = name;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;

  Register.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    return data;
  }
}

class Login {
  String? _token;
  String? _name;
  String? _email;
  int? _id;

  Login({String? token, String? name, String? email, int? id}) {
    if (token != null) {
      this._token = token;
    }
    if (name != null) {
      this._name = name;
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
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  int? get id => _id;
  set id(int? id) => _id = id;

  Login.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _name = json['name'];
    _email = json['email'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    data['name'] = this._name;
    data['email'] = this._email;
    data['id'] = this._id;
    return data;
  }
}

class AllUser {
  int? _id;
  String? _name;
  String? _email;
  String? _password;
  String? _role;
  String? _phoneNumber;
  String? _idCardNumber;
  String? _createdAt;
  String? _updatedAt;

  AllUser(
      {int? id,
      String? name,
      String? email,
      String? password,
      String? role,
      String? phoneNumber,
      String? idCardNumber,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (password != null) {
      this._password = password;
    }
    if (role != null) {
      this._role = role;
    }
    if (phoneNumber != null) {
      this._phoneNumber = phoneNumber;
    }
    if (idCardNumber != null) {
      this._idCardNumber = idCardNumber;
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
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get password => _password;
  set password(String? password) => _password = password;
  String? get role => _role;
  set role(String? role) => _role = role;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;
  String? get idCardNumber => _idCardNumber;
  set idCardNumber(String? idCardNumber) => _idCardNumber = idCardNumber;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  AllUser.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
    _role = json['role'];
    _phoneNumber = json['phone_number'];
    _idCardNumber = json['id_card_number'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['password'] = this._password;
    data['role'] = this._role;
    data['phone_number'] = this._phoneNumber;
    data['id_card_number'] = this._idCardNumber;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class User {
  int? _id;
  String? _name;
  String? _email;
  String? _role;
  String? _phoneNumber;
  String? _idCardNumber;
  String? _createdAt;
  String? _updatedAt;

  User(
      {int? id,
      String? name,
      String? email,
      String? role,
      String? phoneNumber,
      String? idCardNumber,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (role != null) {
      this._role = role;
    }
    if (phoneNumber != null) {
      this._phoneNumber = phoneNumber;
    }
    if (idCardNumber != null) {
      this._idCardNumber = idCardNumber;
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
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get role => _role;
  set role(String? role) => _role = role;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phoneNumber) => _phoneNumber = phoneNumber;
  String? get idCardNumber => _idCardNumber;
  set idCardNumber(String? idCardNumber) => _idCardNumber = idCardNumber;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _role = json['role'];
    _phoneNumber = json['phone_number'];
    _idCardNumber = json['id_card_number'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['role'] = this._role;
    data['phone_number'] = this._phoneNumber;
    data['id_card_number'] = this._idCardNumber;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
