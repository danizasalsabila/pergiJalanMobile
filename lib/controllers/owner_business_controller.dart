import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pergijalan_mobile/models/ownerbusiness.dart';
import 'package:pergijalan_mobile/services/api/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerBusinessController extends ChangeNotifier {
  OwnerBusinessResponse? ownerBusinessResponse;
  LoginOwnerUser? loginOwnerUser;
  String? tokenAuthOBSP;
  OwnerBusinessUser? ownerBusinessUserDetail;

  int? statusCodeRegisterOB;
  String? messageRegisterOB;
  Future<dynamic> registerOwnerBus(
      String namaOwner,
      String email,
      String password,
      String confirmPassword,
      String contactNumber,
      String idCardNumber,
      String address) async {
    print("register owner");
    var url = Uri.parse(BASE_URL + REGISTER_OWNERBUSINESS);
    print("URL = $url");

    try {
      var response = await http.post(url,
          headers: {"content-type": "application/json"},
          body: json.encode({
            'nama_owner': namaOwner,
            'email': email,
            'password': password,
            'confirm_password': confirmPassword,
            'contact_number': contactNumber,
            'id_card_number': idCardNumber,
            'address': address
          }));
      print("code: ${response.statusCode}");
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        statusCodeRegisterOB = response.statusCode;
        messageRegisterOB = data["message"];
        print("data : $data");
        notifyListeners();
      } else if (response.statusCode == 409 ||
          response.statusCode == 422 ||
          response.statusCode == 400) {
        statusCodeRegisterOB = response.statusCode;
        messageRegisterOB = data["message"];
        print("data : $data");

        notifyListeners();
      } else {
        statusCodeRegisterOB = response.statusCode;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE $e");
    }
  }

  int? statusCodeLoginOB;
  String? messageLoginOB;
  Future<dynamic> loginOwnerBusiness(String email, String password) async {
    print("login owner business with email: ");
    var url = Uri.parse(BASE_URL + LOGIN_OWNERBUSINESS);
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
        messageLoginOB = data["message"];
        print("message login: $messageLoginOB");
        statusCodeLoginOB = response.statusCode;

        var data2 = data["data"];
        loginOwnerUser = LoginOwnerUser.fromJson(data2);
        print("login object $loginOwnerUser");
        await setLoginOwnerBusinessPreferences(loginOwnerUser!);
        await getLoginOBPreferences();
        notifyListeners();
      } else if (response.statusCode == 422) {
        print("data : $data");

        messageLoginOB = data["message"];
        print("message login: $messageLoginOB");
        statusCodeLoginOB = response.statusCode;
        notifyListeners();
      } else {
        print("data : $data");

        statusCodeLoginOB = response.statusCode;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE $e");
    }
  }

  String? tokenLogin;
  int? statusCodeLogoutOB;
  String? messageLogoutOB;
  Future<dynamic> logoutOwnerBusiness() async {
    print("Logout OWNER BUSINESS with bearer token");
    print("TOKEN IS REMOVED: $tokenLogin");
    var url = Uri.parse(BASE_URL + LOGOUT_OWNERBUSINESS);
    print("URL = $url");
    try {
      var response = await http.post(url, headers: {
        "content-type": "application/json",
        "authorization": "Bearer $tokenLogin",
      });
      print("code: ${response.statusCode}");
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('login');
        print("user data and token login is removed");

        print("data : $data");
        messageLogoutOB = data["message"];
        print("message login: $messageLogoutOB");
        statusCodeLogoutOB = response.statusCode;
        notifyListeners();
      } else {
        print("data : $data");

        statusCodeLogoutOB = response.statusCode;
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE $e");
    }
  }

  Future<void> setUserResponsePreferences(OwnerBusinessResponse data) async {
    ownerBusinessResponse = data;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'ownerBusinessReponse',
        json.encode({
          'success': ownerBusinessResponse?.success,
          'message': ownerBusinessResponse?.message,
          'data': ownerBusinessResponse?.loginOwnerUser
        }));
    print(
        "Message response from Shared Preferences: ${ownerBusinessResponse!.message}"); // mencetak token dari Shared Preferences ke dalam konsol
  }

  int? idOBLogin;
  String? emailLogin;
  String? nameLogin;
  Future<void> setLoginOwnerBusinessPreferences(
      LoginOwnerUser loginData) async {
    loginOwnerUser = loginData;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'login',
        json.encode({
          'token': loginOwnerUser?.token,
          'nama_owner': loginOwnerUser?.namaOwner,
          'email': loginOwnerUser?.email,
          'id': loginOwnerUser?.id
        }));

    notifyListeners();
  }

  Future<void> getLoginOBPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'login',
        json.encode({
          'token': loginOwnerUser?.token,
          'nama_owner': loginOwnerUser?.namaOwner,
          'email': loginOwnerUser?.email,
          'id': loginOwnerUser?.id
        }));

    emailLogin = prefs.getString('login') != null
        ? json.decode(prefs.getString('login')!)['email']
        : null;
    idOBLogin = prefs.getString('login') != null
        ? json.decode(prefs.getString('login')!)['id']
        : null;
    tokenLogin = prefs.getString('login') != null
        ? json.decode(prefs.getString('login')!)['token']
        : null;
    nameLogin = prefs.getString('login') != null
        ? json.decode(prefs.getString('login')!)['nama_owner']
        : null;
    // final tokenFromPrefs = prefs.getString('login') != null ? json.decode(prefs.getString('login')!)['token'] : null;
    print("Data from Shared Preferences: email: $emailLogin");
    print("Data from Shared Preferences: id: $idOBLogin");
    print("Data from Shared Preferences: token: $tokenLogin");
    print("Data from Shared Preferences: name: $nameLogin");
    notifyListeners();
  }

  Future<dynamic> ownerDetail() async {
    print("Detail User Data");
    print("ID USER: $idOBLogin");
    var url = Uri.parse(BASE_URL + GET_OWNER_BY_ID + "$idOBLogin");
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print("CODE: ${response.statusCode}");
        // print(data);
        var dataDetail = data["data"];
        ownerBusinessUserDetail = OwnerBusinessUser.fromJson(dataDetail);
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

  int? statusCodeEditProfileOwner;
  String? messageEditProfileOwner;
  Future<dynamic> editOwner(
      {idOBLogin,
      String? nameOwner,
      String? contactNumber,
      String? address,
      String? idCardNumber}) async {
    print("EDIT User Data");
    print("ID USER: $idOBLogin");
    var url = Uri.parse(BASE_URL + UPDATE_OWNER(idOBLogin));
    final body = {
      'nama_owner': nameOwner,
      'contact_number': contactNumber,
      'id_card_number': idCardNumber,
      'address': address
    };
    print("URL = $url");
    try {
      var response = await http.put(
        url,
        body: json.encode(body),
        headers: {
          "content-type": "application/json",
        },
      );

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        statusCodeEditProfileOwner = response.statusCode;
        messageEditProfileOwner = data["message"];
        print("CODE: $statusCodeEditProfileOwner");
        print(data);

        notifyListeners();
      } else if (response.statusCode == 404) {
        statusCodeEditProfileOwner = response.statusCode;
        messageEditProfileOwner = data["message"];
        print("CODE: $statusCodeEditProfileOwner");
        var dataError = data["data"];
        print("$dataError");
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
}
