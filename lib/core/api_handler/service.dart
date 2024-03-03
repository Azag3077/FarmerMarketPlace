import 'dart:convert';
import 'dart:developer';

import 'package:farmers_marketplace/core/api_handler/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const String success = 'SUCCESS';
const String failed = 'FAILED';

class ApiService {
  Future<Response> login(String email, String password) async {
    try {
      final Map<String, dynamic> loginData = {
        'email': email.trim(),
        'password': password.trim(),
      };

      final http.Response response = await http.post(
        ApiEndpoints.login,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginData),
      );

      final responseData = jsonDecode(response.body);
      final result = Response.fromJson(responseData);

      if (result.statusMessage == success) {
        return result.copyWith(status: ResponseStatus.success);
      }
      return result.copyWith(status: ResponseStatus.failed);
    } on ConnectionState catch (e) {
      log('[ERROR] $e');
      return Response(status: ResponseStatus.connectionError);
    } catch (e) {
      return Response(status: ResponseStatus.unknownError);
    }
  }

  // Future<void> signupUser() async {
  //   final String signupUrl = "$baseUrl$signupEndpoint";
  //   final Map<String, dynamic> signupData = {
  //     "firstname": "YourFirstName",
  //     "lastname": "YourLastName",
  //     "email": "your_email@example.com",
  //     "password": "your_password",
  //   };
  //
  //   final http.Response response = await http.post(
  //     Uri.parse(signupUrl),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(signupData),
  //   );
  //
  //   final Map<String, dynamic> responseData = jsonDecode(response.body);
  //   print("Signup Response: $responseData");
  // }
}

class Response {
  final String? message;
  final String? statusMessage;
  final ResponseStatus status;
  final Map<String, dynamic>? data;

  Response({
    this.message,
    this.statusMessage,
    required this.status,
    this.data,
  });

  factory Response.fromJson(Map<String, dynamic> data) {
    return Response(
      message: data['message'],
      statusMessage: data['status'],
      status: ResponseStatus.pending,
      data: data['data'],
    );
  }

  Response copyWith({
    String? message,
    String? statusMessage,
    ResponseStatus? status,
    Map<String, dynamic>? data,
  }) {
    return Response(
      message: message ?? this.message,
      statusMessage: statusMessage ?? this.statusMessage,
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}

enum ResponseStatus {
  pending,
  success,
  failed,
  connectionError,
  unknownError,
}

final apiService = ApiService();
