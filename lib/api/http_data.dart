import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../models/signatures.dart';
import '../models/resolutions.dart';

const _url = 'http://10.0.2.2:3000';

String urlBuilder(String endpoint) {
  return '$_url$endpoint';
}

Future<List<Resolution>> fetchResolution() async {
  var url = urlBuilder('/resolutions');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Resolution>((json) => Resolution.fromJson(json)).toList();
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load resolutions');
  }
}

Future<bool> checkMember({String id, String firstName, String lastName}) async {
  var url = urlBuilder('/members/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final parsed = json.decode(response.body);

    if (parsed["first_name"] == firstName && parsed["last_name"] == lastName) {
      return Future<bool>.value(true);
    }
  }
  return Future<bool>.value(false);
}

Future<http.Response> createSignature(Signature signature) async {
  var url = urlBuilder('/signatures');
  var body = json.encode(signature.toJson());

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final response = await http.post(url, body: body, headers: headers);
  print(response.body);
  return response;
}

Future<http.Response> updateSignature(
    {@required int id, @required TypeOfSign choice}) async {
  var url = urlBuilder('/signatures/$id');
  var body = json.encode({
    'type': choice.index,
    'date': DateFormat('dd/MM/yyyy').format(DateTime.now())
  });

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final response = await http.patch(url, body: body, headers: headers);
  return response;
}

checkSignatureId(int resolutionId, int memberID) async {
  var url = urlBuilder('/signatures?_sort=id&_order=asc');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final parsed = json.decode(response.body);
    print(parsed);
    var possibleResolution = parsed.firstWhere(
        (signature) =>
            signature['id_resolution'] == resolutionId &&
            signature['id_member'] == memberID,
        orElse: () => null);
    if (possibleResolution == null) {
      var tempId = parsed.last['id'] + 1;
      return tempId;
    } else {
      return possibleResolution;
    }
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Connection error: failed to load signatures');
  }
}
// TODO: multiple updates podczas jednej sesji na formularzu
//data ostatniej zmiany
//pull to refresh
//resolution list jeśli odpowiedziałem to info na co zagłosowałem
//redesign
//floating buttons z dodawaniem ustawy
//finish date check
