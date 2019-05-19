import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/signatures.dart';
import '../models/resolutions.dart';

Future<List<Resolution>> fetchResolution() async {
  var url = 'http://10.0.2.2:3000/resolutions';
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    // TODO: zamienić na generyczną
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Resolution>((json) => Resolution.fromJson(json)).toList();
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<bool> checkMember({String id, String firstName, String lastName}) async {
  var url = 'http://10.0.2.2:3000/members';
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final parsed = json.decode(response.body);
    for (var item in parsed) {
      if (item["id"] == int.parse(id) &&
          item["first_name"] == firstName.toString() &&
          item["last_name"] == lastName.toString()) {
        return Future<bool>.value(true);
      }
    }

    return Future<bool>.value(false);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Connection error: failed to load post');
  }
}

// Future createSignature(Signature signature) async {
//   var url = 'http://10.0.2.2:3000/signatures';
//   final response = await http.post(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: signature.toJson(),
//   );
//   //return Signature.fromJson(json.decode(response.body));
// }
Future<http.Response> createSignature(Signature signature) async {
  var url = "http://10.0.2.2:3000/signatures";
  var body = json.encode(signature.toJson());

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final response = await http.post(url, body: body, headers: headers);
  return response;
}
