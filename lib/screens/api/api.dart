import 'dart:convert';

import 'package:chat_gpt_demo/screens/utils/constants.dart';
import 'package:http/http.dart' as http;

class API {
  static final API _singleton = API._internal();
  API._internal();

  factory API() {
    return _singleton;
  }

  static API shared = API();

  Future getMessage(String message) async {
    var response = await http.post(Uri.parse(baseUrl),
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": message,
          "max_tokens": 4000,
          "temperature": 0.9
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': ('Bearer ') + apiKey
        });
    return json.decode(response.body);
  }
}
