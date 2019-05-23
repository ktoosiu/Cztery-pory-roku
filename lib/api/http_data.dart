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

  return response;
}

Future<http.Response> updateSignature(
    {@required int id, @required TypeOfSign choice}) async {
  var url = urlBuilder('/signatures/$id');
  var body = json.encode({
    'type': choice.index,
    'update_date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
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

    var possibleResolution = parsed.firstWhere(
        (signature) =>
            signature['id_resolution'] == resolutionId &&
            signature['id_member'] == memberID,
        orElse: () => null);
    if (possibleResolution == null) {
      if (parsed.isNotEmpty) {
        var tempId = parsed.last['id'] + 1; //int
        return tempId;
      } else {
        return 1;
      }
    } else {
      return possibleResolution;
    }
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Connection error: failed to load signatures');
  }
}

Future<http.Response> createResolution(Resolution resolution) async {
  var url = urlBuilder('/resolutions');
  var body = json.encode(resolution.toJson());
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final response = await http.post(url, body: body, headers: headers);

  return response;
}

checkUserName(int memberId) async {
  var url = urlBuilder('/members?_sort=id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final parsed = json.decode(response.body);

    var member = parsed.firstWhere((signature) => signature['id'] == memberId,
        orElse: () => null);
    if (member != null) {
      return '${member["first_name"]} ${member["last_name"]}';
    }
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Connection error: failed to load signatures');
  }
}
