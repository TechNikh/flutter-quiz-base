import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:quiz_app/data/objects/mcq.dart';

class QuestionsApiService {
  static const String baseUrl = 'https://pastebin.com';

  Future<List<Map<String, dynamic>>> fetchQuestions() async {
    final Uri uri = Uri.parse('$baseUrl/raw/L1qQZyhm');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);
      List<Map<String, dynamic>> result = [];
      for (final map in responseBody) {
        result.add(map);
      }
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<void> createPaste() async {
  //   const apiEndpoint = '$baseUrl/api/api_post.php';
  //   const apiKey = 'E9OKOdvfH_LregCXy8sgf4qTUZqmbqBJ'; // Replace with your Pastebin API key
  //   final data = mcqSamples; // provide the data you want to upload here

  //   final response = await http.post(Uri.parse(apiEndpoint), body: {
  //     'api_option': 'paste',
  //     'api_dev_key': apiKey,
  //     'api_paste_code': jsonEncode(data),
  //     'api_paste_private': '0', // public = 0, unlisted = 1, private = 2
  //     'api_paste_format': 'json',
  //   });

  //   if (response.statusCode == 200) {
  //     final responseData = response.body;
  //     print('Paste created successfully. URL: $responseData');
  //   } else {
  //     print('Error creating paste: ${response.statusCode}');
  //   }
  // }
}
