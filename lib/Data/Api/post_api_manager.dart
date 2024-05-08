 // ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Utils/constant_widgets.dart';
import '../model/error_model.dart';
import 'api_exception.dart';

class PostAPIManager {
  var authToken1 =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpAZ21haWwuY29tIiwiaWF0IjoxNjc5Mzc0MjE4fQ.yrhNKbtsCfyuIZj4MBqeCJENu48fT-GWe3f0Voqh06A";

  ///***************************** Used to call get API method, pass the url for api call *****************************///

  Future<dynamic> getAPICall(
      {required String url,
      bool isLoaderShow = true,
      var authToken,
      bool isToken = false}) async {
    var responseJson;
    print("[Calling API] => $url");

    try {
      ///***************************** Show progress loader *****************************///

      if (isLoaderShow == true) {
        showProgressIndicator();
      }

      ///***************************** Set header for send request *****************************///
      var headers;
      if (isToken == false) {
        headers = getAuthToken() == ""
            ? {
                "Content-Type": "application/json",
              }
            : {
                "Content-Type": "application/json",
                "Authorization": "Bearer ${getAuthToken()}",
              };
      } else {
        headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken1",
        };
      }

      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 20))
          .onError(
        (error, stackTrace) {
          errorSnackBar(message: 'No Internet Connection');
          throw FetchDataException('No Internet Connection');
        },
      );
      log("<-------------------- [GET API RESPONSE] -------------------->");
      log(response.body);
      log('<------------------------------------------------------------>');
      responseJson = _response(response);
    } on SocketException {
      ///***************************** Show error message on SocketException *****************************///

      Get.showSnackbar(errorSnackBar(message: 'No Internet Connection'));
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      ///***************************** Throw error message on TimeoutException *****************************///

      throw FetchDataException('Server Error');
    } finally {
      ///***************************** Hide progress loader *****************************///

      if (isLoaderShow == true) {
        dismissProgressIndicator();
      }
    }

    return responseJson;
  }

  ///***************************** Used to call post API method, pass the url and param for api call *****************************///

  Future<dynamic> postAPICall(
      {required String url,
      required Map params,
      bool isToken = false,
      bool isLoaderShow = true}) async {
    var responseJson;
    print("[Calling API] => $url");
    print("[Calling parameters] => $params");

    try {
      ///***************************** Show progress loader *****************************///

      if (isLoaderShow == true) {
        showProgressIndicator();
      }

      ///***************************** Set header for send request *****************************///

      var headers = getAuthToken() == ""
          ? {
              "Content-Type": "application/json",
            }
          : {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${getAuthToken()}",
            };

      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: json.encode(params),
          )
          .timeout(const Duration(seconds: 15))
          .onError(
        (error, stackTrace) {
          errorSnackBar(message: 'No Internet Connection');
          throw FetchDataException('No Internet Connection');
        },
      );

      log("<-------------------- [POST API RESPONSE] -------------------->");
      log(response.body);
      log('<------------------------------------------------------------->');
      responseJson = _response(response);
    } on SocketException {
      ///***************************** Show error message on SocketException *****************************///

      errorSnackBar(message: 'No Internet Connection');
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (_) {
      ///***************************** Throw error message on TimeoutException *****************************///

      throw FetchDataException('Server Error');
    } finally {
      ///***************************** Hide progress loader *****************************///

      if (isLoaderShow == true) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  ///***************************** Used to call patch API method, pass the url and param for api call *****************************///

  Future<dynamic> patchAPICall(
      {required String url,
      required Map params,
      bool isLoaderShow = true,
      bool isToken = false}) async {
    print("Calling API: $url");
    print("Calling parameters: $params");

    var responseJson;
    try {
      ///***************************** Show progress loader *****************************///

      if (isLoaderShow == true) {
        showProgressIndicator();
      }

      ///***************************** Set header for send request *****************************///

      var headers;
      if (isToken == false) {
        headers = getAuthToken() == ""
            ? {
                "Content-Type": "application/json",
              }
            : {
                "Content-Type": "application/json",
                "Authorization": "Bearer ${getAuthToken()}",
              };
      } else {
        headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken1",
        };
      }
      print("Headers:${headers}");

      final response = await http
          .patch(Uri.parse(url), headers: headers, body: json.encode(params))
          .timeout(Duration(seconds: 15))
          .onError(
        (error, stackTrace) {
          errorSnackBar(message: 'No Internet Connection');
          throw FetchDataException('No Internet Connection');
        },
      );

      log("<-------------------- [PATCH API RESPONSE] -------------------->");
      log(response.body);
      log('<------------------------------------------------------------>');

      responseJson = _response(response);
    } on SocketException {
      ///***************************** Show error message on SocketException *****************************///

      throw FetchDataException('No internet connection');
    } on TimeoutException catch (_) {
      ///***************************** Throw error message on TimeoutException *****************************///

      throw FetchDataException('Server Error');
    } finally {
      ///***************************** Hide progress loader *****************************///

      if (isLoaderShow == true) {
        dismissProgressIndicator();
      }
    }
    return responseJson;
  }

  ///***************************** Check response status and handle exception *****************************///

  dynamic _response(http.Response response) async {
    switch (response.statusCode) {
      ///***************************** Successfully get api response *****************************///

      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
    

      ///***************************** Bad request need to check url *****************************///

      case 400:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw BadRequestException(
          ErrorModel.fromJson(json.decode(response.body)).message,
        );

      ///***************************** Authorisation token invalid *****************************///

      case 403:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw UnauthorisedException(
          ErrorModel.fromJson(json.decode(response.body)).message,
        );

      ///***************************** Error occured while Communication with Server *****************************///

      case 500:
      default:
        errorSnackBar(
          message: ErrorModel.fromJson(json.decode(response.body)).message,
        );
        throw FetchDataException(
          'An error occured while communication with server with status code: ${response.statusCode}',
        );
    }
  }
}
