import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pergijalan_mobile/models/user.dart';
import 'package:pergijalan_mobile/services/api/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ChangeNotifier {
  UserResponse? userResponse;
  User? userDataDetail;
  // List<User>? userData;
  // List<User> userData =[];

  Login? login;
  // String? tokenAuthSP;

  int? statusCodeRegister;
  String? messageRegister;
  Future<dynamic> registerUser(String name, String email, String password,
      String confirmPassword, String phoneNumber, String idCardNumber) async {
    print("register user");
    print("email $email");
    var url = Uri.parse(BASE_URL + REGISTER_USER);
    print("URL = $url");

    try {
      var response = await http.post(url,
          headers: {"content-type": "application/json"},
          body: json.encode({
            'name': name,
            'email': email,
            'password': password,
            'confirm_password': confirmPassword,
            'phone_number': phoneNumber,
            'id_card_number': idCardNumber
          }));
      print("code: ${response.statusCode}");
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        statusCodeRegister = response.statusCode;
        print("data : $data");
        messageRegister = data["message"];
        notifyListeners();
      } else if (response.statusCode == 409) {
        statusCodeRegister = response.statusCode;
        messageRegister = data["message"];

        print("data : $data");
        notifyListeners();
      } else if (response.statusCode == 422) {
        statusCodeRegister = response.statusCode;
        messageRegister = data["message"];

        print("data : $data");
        notifyListeners();
      } else if (response.statusCode == 400) {
        statusCodeRegister = response.statusCode;
        messageRegister = data["message"];

        print("data : $data");
        notifyListeners();
      } else {
        statusCodeRegister = response.statusCode;

        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE $e");

    }
  }

  int? statusCodeLogin;
  String? messageLogin;
  // String? tokenAuth;
  Future<dynamic> loginUser(String email, String password) async {
    print("login user with email: ");
    var url = Uri.parse(BASE_URL + LOGIN_USER);
    print("URL = $url");
    try {
      var response = await http.post(url,
          headers: {"content-type": "application/json"},
          body: json.encode({
            'email': email,
            'password': password,
          }));
      print("code: ${response.statusCode}");
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        print("data : $data");

        messageLogin = data["message"];
        print("message login: $messageLogin");
        statusCodeLogin = response.statusCode;
        // tokenAuthSP = data["data"]["token"];

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.getString("getTokenUser") ?? "";
        // tokenAuth = data["data"]["token"];
        // print("Bearer Token: $tokenAuth");
        print("==");
        // userResponse = UserResponse.fromJson(data);
        // await setUserResponsePreferences(userResponse!);

        var data2 = data["data"];
        login = Login.fromJson(data2);
        print("login object $login");
        await setLoginPreferences(login!);
        await getLoginPreferences();
        // final prefs = await SharedPreferences.getInstance();
        // final tokenAuth = prefs.getString('login') ??"";
        //  print("token SP: $tokenAuth");

        notifyListeners();
      } else if (response.statusCode == 422) {
        print("data : $data");

        messageLogin = data["message"];
        print("message login: $messageLogin");
        statusCodeLogin = response.statusCode;
        notifyListeners();
      } else {
        print("data : $data");

        statusCodeLogin = response.statusCode;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE $e");
    }
  }

  int? statusCodeLogout;
  String? messageLogout;
  Future<dynamic> logoutUser() async {
    print("Logout user with bearer token");
    print("TOKEN IS REMOVED: $tokenLogin");
    var url = Uri.parse(BASE_URL + LOGOUT_USER);
    print("URL = $url");
    try {
      var response = await http.post(url, 
      headers: {
        "content-type": "application/json",
        "authorization": "Bearer $tokenLogin",
      });
      print("code: ${response.statusCode}");
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('login');
        print("user data login is removed");

        print("data : $data");
        messageLogout = data["message"];
        print("message login: $messageLogout");
        statusCodeLogout = response.statusCode;
        var data2 = data["data"];
        notifyListeners();
      } else {
        print("data : $data");

        statusCodeLogout = response.statusCode;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE $e");
    }
  }

  Future<void> setUserResponsePreferences(UserResponse data) async {
    userResponse = data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'userReponse',
        json.encode({
          'status': userResponse?.status,
          'message': userResponse?.message,
          'data': userResponse?.login
        }));
    print(
        "Message response from Shared Preferences: ${userResponse!.message}"); // mencetak token dari Shared Preferences ke dalam konsol
  }

  int? idUserLogin;
  String? emailLogin;
  String? nameLogin;
  String? tokenLogin;
  Future<void> setLoginPreferences(Login loginData) async {
    login = loginData;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'login',
        json.encode({
          'token': login?.token,
          'name': login?.name,
          'email': login?.email,
          'id': login?.id
        }));

    notifyListeners();
  }

  Future<void> getLoginPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'login',
        json.encode({
          'token': login?.token,
          'name': login?.name,
          'email': login?.email,
          'id': login?.id
        }));

    emailLogin = prefs.getString('login') != null
        ? json.decode(prefs.getString('login')!)['email']
        : null;
    idUserLogin = prefs.getString('login') != null
        ? json.decode(prefs.getString('login')!)['id']
        : null;
    tokenLogin = prefs.getString('login') != null
        ? json.decode(prefs.getString('login')!)['token']
        : null;
    nameLogin = prefs.getString('login') != null
        ? json.decode(prefs.getString('login')!)['name']
        : null;
    // final tokenFromPrefs = prefs.getString('login') != null ? json.decode(prefs.getString('login')!)['token'] : null;
    print("Data from Shared Preferences: email: $emailLogin");
    print("Data from Shared Preferences: id: $idUserLogin");
    print("Data from Shared Preferences: token: $tokenLogin");
    print("Data from Shared Preferences: name: $nameLogin");
    notifyListeners();
  }

  // Future<void> getUserPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   String getUserDataPreferences = prefs.getString('login') ?? "";

  //   if (getUserDataPreferences == "") {
  //     print("no data that on prefs");
  //     return;
  //   } else {
  //     // var getUserSavedPreferences = jsonDecode(getUserDataPreferences);
  //     // login = Login.fromJson(getUserSavedPreferences);
  //     idUserSP = login?.id;
  //     tokenAuthSP = login?.token;
  //     emailSP = login?.email;
  //     nameSP = login?.name;
  //     print("TOKEN PREFERENCES :$tokenAuthSP");
  //     notifyListeners();
  //   }
  // }

  // Future<void> getToken(String token) async {
  //       final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("getTokenUser", json.encode({'token':}) )
  // }

    Future<dynamic> userDetail() async {
    print("Detail User Data");
    print("ID USER: $idUserLogin");
    var url = Uri.parse(BASE_URL + GET_USER_BY_ID + "$idUserLogin");
    print("URL = $url");
    try {
      var response = await http.get(url);
      
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print("CODE: ${response.statusCode}");
        print(data);
        var dataDetail = data["data"];
        userDataDetail = User.fromJson(dataDetail);
        notifyListeners();
      } else if (response.statusCode == 404) {
        print("CODE: ${response.statusCode}");
        var dataError = data["data"];
        print("$dataError");
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
}
