import 'dart:convert';

import 'package:http/http.dart' as http;

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

// Future<Signature> createPost(Signature post) async{
//   final response = await http.post('$url',
//       headers: {
//         HttpHeaders.contentTypeHeader: 'application/json'
//       },
//       body: postToJson(post)
//   );
//   return postFromJson(response.body);
// }