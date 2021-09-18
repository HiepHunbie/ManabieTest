import 'dart:async';
import 'dart:convert';

import 'package:demo/http/url.dart';
import 'package:http/http.dart' as http;

class Request {
  final String url;
  final dynamic body;

  Request({required this.url, this.body});

  Future<http.Response> post() {
    return http
        .post(Uri.parse(urlBase + url),
            headers: {'Content-Type': 'application/json; charset=utf-8'},
            body: json.encode(body))
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> put() {
    return http
        .put(Uri.parse(urlBase + url),
            headers: {'Content-Type': 'application/json; charset=utf-8'},
            body: json.encode(body))
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> get() {
    return http.get(Uri.parse(urlBase + url), headers: {'Content-Type': 'application/json; charset=utf-8'}).timeout(const Duration(seconds: 10));
  }

}
