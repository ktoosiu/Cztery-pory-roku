import 'dart:async';
import 'dart:convert';

import 'package:cztery_pory_roku/models/members.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../models/signatures.dart';
import '../models/resolutions.dart';

const _url = 'http://10.0.2.2:3000';

Map<String, String> _headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

String urlBuilder(String endpoint) {
  return '$_url$endpoint';
}

Future<List<Resolution>> fetchResolution() async {
  var url = urlBuilder('/resolutions');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Resolution>((json) => Resolution.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load resolutions');
  }
}

Future<List<Member>> fetchMembers() async {
  var url = urlBuilder('/members');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Member>((json) => Member.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load resolutions');
  }
}

Future<Member> addMember(Member member) async {
  var url = urlBuilder('/members');
  var body = json.encode(member.toJson());

  final response = await http.post(url, body: body, headers: _headers);
  return Member.fromJson(json.decode(response.body).cast<String, dynamic>());
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

Future<Signature> createSignature(Signature signature) async {
  var url = urlBuilder('/signatures');
  var body = json.encode(signature.toJson());

  final response = await http.post(url, body: body, headers: _headers);
  return Signature.fromJson(json.decode(response.body).cast<String, dynamic>());
}

Future<http.Response> updateSignature(
    {@required int id, @required TypeOfSign choice}) async {
  var url = urlBuilder('/signatures/$id');
  var body = json.encode({
    'type': choice.index,
    'update_date': DateFormat('dd/MM/yyyy').format(DateTime.now()),
  });

  final response = await http.patch(url, body: body, headers: _headers);
  return response;
}

Future<List<Signature>> fetchUserSignatures(int userId) async {
  var url = urlBuilder('/signatures?memberId=$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Signature>((json) => Signature.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load resolutions');
  }
}

Future<Resolution> createResolution(Resolution resolution) async {
  var url = urlBuilder('/resolutions');
  var body = json.encode(resolution.toJson());

  final response = await http.post(url, body: body, headers: _headers);
  return Resolution.fromJson(
      json.decode(response.body).cast<String, dynamic>());
}
