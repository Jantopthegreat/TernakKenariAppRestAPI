import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = "https://10.0.0.2/api/";
  final secureStorage = FlutterSecureStorage();

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<http.Response> postWithToken(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final token = await secureStorage.read(key: 'token');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final token = await secureStorage.read(key: 'token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
