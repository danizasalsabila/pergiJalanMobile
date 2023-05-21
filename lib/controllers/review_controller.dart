import 'dart:convert';
import 'dart:ffi';

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
  String? messageAddReview;
  Future<dynamic> addReviewId(
      {int? id, required int? rating, required String review}) async {
    print("add review destination");
    print("ID DESTINASI : $id");
    print("RATING : $rating");
    print("REVIEW : $review");

    var url = Uri.parse(BASE_URL + POST_REVIEW);
    print("URL = $url");
    final body = {'id_destinasi': id, 'rating': rating, 'review': review};
    try {
      var response = await http.post(
        url,
        body: json.encode(body),
        headers: {"content-type": "application/json"},
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        print("new review added");

        statusCode = response.statusCode;
        print("CODE : $statusCode");
        data = data["data"];
        messageAddReview = data["message"];
        print("DATA : $data");
        notifyListeners();
      } else if (response.statusCode == 404) {
        statusCode = response.statusCode;
        print("CODE : $statusCode");
        messageAddReview = data["message"];
        notifyListeners();
      } else {
        statusCode = response.statusCode;
        // print("status code: ${response.statusCode}");
        // print("status code: ${response.body}");
        // print("status code: ${response.request}");
        // print("status code: ${response.bodyBytes}");
        // print("status code: ${response.headers}");
        notifyListeners();
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }

  double? avgRating;
  int? avgRatingInt;
  bool? isRatingInt;
  var value;
  int? statusCodeAvgRating;
  String? messageAvgRating;
  Future<dynamic> getRatingAverageById(id) async {
    print("get average rating destinasi by $id");

    var url = Uri.parse(BASE_URL + GET_AVG_RATING_ID(id));
    print("URL = $url");
    try {
      var response = await http.get(url);

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        statusCodeAvgRating = response.statusCode;

        //check rating tipe data and convert into double
        value = data["rating"];
        if (value.runtimeType == int) {
          isRatingInt = true;
          avgRatingInt = value;
          avgRating = avgRatingInt!.toDouble();
        } else if (value.runtimeType == double) {
          isRatingInt = false;
          avgRating = value;
        }

        // print(value);
        print("rata-rata : $avgRating");
        print("code: ${response.statusCode}");
        notifyListeners();
      } else if (response.statusCode == 202) {
        statusCodeAvgRating = response.statusCode;
        messageAvgRating = data["message"];
        // print(messageAvgRating);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        statusCodeAvgRating = response.statusCode;
        messageAvgRating = data["message"];
        // print(messageAvgRating);
      } else {
        statusCodeAvgRating = response.statusCode;
      }
    } catch (e) {
      print("ERROR MESSAGE: $e");
    }
  }
}
