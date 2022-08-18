import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> translate(String source, String target, String query) async {
  String targetText = '';
  final responseData = await http.post(
    Uri.parse(
        'https://google-translate1.p.rapidapi.com/language/translate/v2/translate?'),
    headers: {
      'content-type': "application/x-www-form-urlencoded",
      'Accept-Encoding': "application/gzip",
      'X-RapidAPI-Key': "21b2cc4651msha46a43a31fc93f2p11c402jsnee93d4687d68",
      'X-RapidAPI-Host': "google-translate1.p.rapidapi.com"
    },
    body: jsonEncode(
        <String, String>{'source': source, 'target': target, 'q': query}),
  );
  print(responseData.body.toString());
  if (responseData.statusCode == 200) {
    final data = jsonDecode(responseData.body);

    print(data);
  }
  return targetText;
}
