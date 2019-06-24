import 'dart:async';
import 'dart:convert';

import 'package:cztery_pory_roku/models/login_model.dart';
import 'package:cztery_pory_roku/models/members.dart';
import 'package:cztery_pory_roku/models/resolution_group.dart';
import 'package:http/http.dart' as http;

import '../models/signatures.dart';
import '../models/resolutions.dart';

const _url = 'http://resolution.azurewebsites.net/api';

Map<String, String> _headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

String urlBuilder(String endpoint) {
  return '$_url$endpoint';
}

Future<List<Resolution>> fetchResolution(groupId) async {
  var url = urlBuilder('/resolutions?groupId=$groupId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Resolution>((json) => Resolution.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load resolutions');
  }
}

Future deleteMember(memberId) async {
  if (memberId != 1) {
    var url = urlBuilder('/members/$memberId');

    await http.delete(url, headers: _headers);
  }
}

Future<List<ResolutionGroup>> fetchResolutionGroup() async {
  var url = urlBuilder('/ResolutionGroups');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed
        .map<ResolutionGroup>((json) => ResolutionGroup.fromJson(json))
        .toList();
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

Future<LoginModel> checkMember(
    {String id, String firstName, String lastName}) async {
  var url = urlBuilder('/members/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final parsed = json.decode(response.body);
    if (parsed["firstName"] == firstName && parsed["lastName"] == lastName) {
      if (parsed["admin"] == true) {
        return LoginModel(true, true);
      }
      return LoginModel(true, false);
    }
  }
  return LoginModel(false, false);
}

Future<Signature> createSignature(Signature signature) async {
  var url = urlBuilder('/signatures');
  var body = json.encode(signature.toJson());

  final response = await http.post(url, body: body, headers: _headers);
  return Signature.fromJson(json.decode(response.body).cast<String, dynamic>());
}

Future<http.Response> updateSignature(Signature signature) async {
  var url = urlBuilder('/signatures/${signature.id}');
  var body = json.encode(signature.toJson());

  final response = await http.put(url, body: body, headers: _headers);
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

Future<ResolutionGroup> addResolutionGroup(ResolutionGroup group) async {
  var url = urlBuilder('/ResolutionGroups');
  var body = json.encode(group.toJson());

  final response = await http.post(url, body: body, headers: _headers);
  return ResolutionGroup.fromJson(
      json.decode(response.body).cast<String, dynamic>());
}
