import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:translate_app/models/traslate.dart';

translate(String source, String target, String query) async {
  List<Translation> translations = [];
  print('q={$query}&target={$target}&source={$source}');
  String targetText = '';
  var headers = {
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
    'X-RapidAPI-Key': '21b2cc4651msha46a43a31fc93f2p11c402jsnee93d4687d68',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://google-translate1.p.rapidapi.com/language/translate/v2'));
  request.bodyFields = {'q': query, 'target': target, 'source': source};
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var data = jsonDecode(await response.stream.bytesToString());
    final translation = data['data']['translations'];
    translations = []; // clear list
    for (Map<String, dynamic> i in translation) {
      translations.add(Translation.fromJson(i));
    }
    targetText = translations[0].translation.toString();
  } else {
    print(response.reasonPhrase);
  }
  print(targetText);
  return targetText;
}
