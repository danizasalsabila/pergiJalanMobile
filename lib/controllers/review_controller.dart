import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pergijalan_mobile/models/review.dart';

import '../models/destinasi.dart';
import '../services/api/url.dart';

class ReviewController extends ChangeNotifier {
  ReviewResponse? reviewResponse;
  List<Review>? reviewData;

  Future<dynamic> reviewDestinasiId(id) async {
    print("get review destinasi by id");

    var url = Uri.parse(BASE_URL + GET_REVIEW_ID(id));
    print("URL = $url");
    try {
      var client = http.Client();
      // var response = await http.get(url);
      var response = await client.get(url);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        print("code: ${response.statusCode}");
        print(data["status"]);

        reviewResponse = reviewResponseFromJson(response.body);
        reviewData = reviewResponse?.review;
        notifyListeners();
      } else if (response.statusCode == 404) {
        print(data["message"]);
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  int? statusCode;
  Future<dynamic> addReviewId(
      {int? id, required double? rating, required String review}) async {
    print("add review destination");
    print("ID WISATA : $id");
    print("RATING : $rating");
    print("REVIEW : $review");

    var url = Uri.parse(BASE_URL + POST_REVIEW);
    print("URL = $url");
    try {
      var client = http.Client();
      // var response = await http.get(url);
      var response = await client.post(
        url,
        body: jsonEncode({"id": id, "rating": rating, "review": review}),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        

      );
      print("code: ${response.statusCode}");

      if (response.statusCode == 200) {
      print("masuk--");

        print("code: ${response.statusCode}");
        statusCode = response.statusCode;
        print("new review added");
        notifyListeners();
      } else if (response.statusCode == 302){
        print("b");
      }else if
      
       (response.statusCode == 404) {
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
}
