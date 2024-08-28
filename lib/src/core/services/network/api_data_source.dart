import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:technical_assessment_flutter/src/core/constants/globals.dart';
import 'package:technical_assessment_flutter/src/core/services/network/app_exceptions.dart';

class NetworkApi {
  static NetworkApi? _instance;
  static final Dio _dio = Dio();

  /// Replace with actual authentication mechanism currently send null for mock apis
  static Map<String, dynamic> get header {
    return {"Authorization": null};
  }

  NetworkApi._();

  static NetworkApi get instance {
    _instance ??= NetworkApi._();
    return _instance!;
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.none;
  }

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
  }) async {
    _printRequestDetails(
      methodType: "GET",
      url: url,
      apiHeader: customHeader ?? header,
      params: params,
    );

    return _handleRequest(() async {
      return await _dio.get(
        url,
        queryParameters: params,
        options: _buildDioOptions(customHeader),
      );
    });
  }

  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? customHeader,
    List<MapEntry<String, File>>? files,
  }) async {
    _printRequestDetails(
      methodType: "POST",
      url: url,
      apiHeader: customHeader ?? header,
      body: body,
    );

    return _handleRequest(() async {
      var data = files != null && files.isNotEmpty
          ? await _prepareFormData(body, files)
          : body;
      return await _dio.post(
        url,
        data: data,
        options: _buildDioOptions(customHeader),
      );
    });
  }

  Future<dynamic> patch({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? customHeader,
    List<MapEntry<String, File>>? files,
  }) async {
    _printRequestDetails(
      methodType: "PATCH",
      url: url,
      apiHeader: customHeader ?? header,
      body: body,
    );

    return _handleRequest(() async {
      var data = files != null && files.isNotEmpty
          ? await _prepareFormData(body, files)
          : body;
      return await _dio.patch(
        url,
        data: data,
        options: _buildDioOptions(customHeader),
      );
    });
  }

  Future<dynamic> put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? customHeader,
    List<MapEntry<String, File>>? files,
  }) async {
    _printRequestDetails(
      methodType: "PUT",
      url: url,
      apiHeader: customHeader ?? header,
      body: body,
    );

    return _handleRequest(() async {
      var data = files != null && files.isNotEmpty
          ? await _prepareFormData(body, files)
          : body;
      return await _dio.put(
        url,
        data: data,
        options: _buildDioOptions(customHeader),
      );
    });
  }

  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
  }) async {
    _printRequestDetails(
      methodType: "DELETE",
      url: url,
      apiHeader: customHeader ?? header,
      params: params,
    );

    return _handleRequest(() async {
      return await _dio.delete(
        url,
        options: _buildDioOptions(customHeader),
      );
    });
  }

  Future<dynamic> _handleRequest(
      Future<Response<dynamic>> Function() request) async {
    try {
      if (await checkConnectivity()) {
        throw "No Internet Connection";
      }
      final response = await request();
      return _returnResponse(response.data);
    } on DioException catch (e) {
      throw DioExceptionError(_getDioExceptionErrorMessage(e));
    }
  }

  Options _buildDioOptions(Map<String, dynamic>? customHeader) {
    return Options(
      headers: customHeader ?? header,
      sendTimeout: const Duration(milliseconds: 22000),
      receiveTimeout: const Duration(milliseconds: 22000),
    );
  }

  Future<FormData> _prepareFormData(
    Map<String, dynamic>? body,
    List<MapEntry<String, File>> files,
  ) async {
    FormData formData = FormData();
    body?.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    for (var fileEntry in files) {
      String fileName = fileEntry.value.path.split('/').last;
      log("Adding file: ${fileEntry.key} - ${fileEntry.value.path}");
      formData.files.add(
        MapEntry(
          fileEntry.key,
          await MultipartFile.fromFile(
            fileEntry.value.path,
            filename: fileName,
          ),
        ),
      );
    }
    return formData;
  }

  String _getDioExceptionErrorMessage(DioException exception) {
    if (kDebugMode) {
      log("Exception type: ${exception.type}, Response: ${exception.response?.data}");
    }
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out";
      case DioExceptionType.receiveTimeout:
        return "Receive timed out";
      case DioExceptionType.sendTimeout:
        return "Send timed out";
      case DioExceptionType.cancel:
        return "Request cancelled";
      case DioExceptionType.badCertificate:
        return "Invalid certificate";
      case DioExceptionType.badResponse:
        return "${exception.response?.data?['error'] ?? 'Bad response from server. Try again later!'}";
      case DioExceptionType.connectionError:
        return "Connection error";
      case DioExceptionType.unknown:
      default:
        return "Unknown error";
    }
  }

  dynamic _returnResponse(dynamic response) {
    if (kDebugMode) {
      log("Response: $response");
    }

    // if (response['status'] != null && response['status'] is num) {
    //   switch (response['status']) {
    //     case 200:
    //     case 201:
    //       return response;
    //     default:
    //       throw response['message'];
    //   }
    // } else {
    return response;
    // }
  }

  void _printRequestDetails({
    required String methodType,
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    required Map<String, dynamic> apiHeader,
  }) {
    debugPrint(
        "------------------------- $methodType ---------------------------");
    debugPrint("URL: $url");
    if (body != null) debugPrint("Body: $body");
    if (params != null) debugPrint("Params: $params");
    debugPrint("Headers: $apiHeader");
    debugPrint(
        "-------------------------------------------------------------------");
  }
}
