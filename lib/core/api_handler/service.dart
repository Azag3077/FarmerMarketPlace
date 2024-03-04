import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'endpoints.dart';
import 'models.dart';
export 'models.dart';

class ApiService {
  final _headers = {"Content-Type": "application/json"};
  final String success = 'SUCCESS', failed = 'FAILED';

  // country_state_city

  Future<Response> _requests(Uri url, Map<String, dynamic> data) async {
    try {
      final http.Response response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);
      final result = Response.fromJson(responseData);

      log(responseData.toString());

      if (result.statusMessage == success) {
        return result.copyWith(status: ResponseStatus.success);
      }
      return result.copyWith(status: ResponseStatus.failed);
    } on SocketException catch (e) {
      log('[SocketException] $e');
      return Response(status: ResponseStatus.connectionError);
    } catch (e) {
      log('[UNKNOWN ERROR] $e');
      return Response(status: ResponseStatus.unknownError);
    }
  }

  Future<Response> login(String email, String password) async {
    final data = {'email': email.trim(), 'password': password.trim()};
    return await _requests(ApiEndpoints.login, data);
  }

  Future<Response> signup(
      String firstname, String lastname, String email, String password) async {
    final data = {
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'email': email.trim(),
      'password': password.trim(),
    };
    return await _requests(ApiEndpoints.signup, data);
  }

  Future<Response> forgotPassword(String email) async {
    final data = {'email': email.trim()};
    return await _requests(ApiEndpoints.forgotPassword, data);
  }

  Future<Response> confirmReset(
      String email, String password, String otp) async {
    final data = {
      'email': email.trim(),
      'password': password.trim(),
      'otp': otp.trim(),
    };
    return await _requests(ApiEndpoints.confirmReset, data);
  }

  Future<Response> sendOtp(String email) async {
    final data = {'email': email.trim()};
    return await _requests(ApiEndpoints.sendOtp, data);
  }

  Future<Response> verifyOtp(String email, String otp) async {
    final data = {'email': email.trim(), 'otp': otp.trim()};
    return await _requests(ApiEndpoints.verifyOtp, data);
  }

  Future<void> az() async {
    var headers = {'X-CSCAPI-KEY': 'API_KEY'};

    var request = http.Request(
        'GET', Uri.parse('https://api.countrystatecity.in/v1/states'));

    request.headers.addAll(headers);
    // request.;

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

final apiService = ApiService();
