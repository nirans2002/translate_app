import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:translate_app/models/languages.dart';

Future getData() async {
  final responseData = await http.get(
      Uri.parse(
          'https://google-translate1.p.rapidapi.com/language/translate/v2/languages'),
      headers: {
        'Accept-Encoding': "application/gzip",
        'X-RapidAPI-Key': "21b2cc4651msha46a43a31fc93f2p11c402jsnee93d4687d68",
        'X-RapidAPI-Host': "google-translate1.p.rapidapi.com"
      });
  print(responseData.body.toString());
  if (responseData.statusCode == 200) {
    final data = jsonDecode(responseData.body);
    final language = data['data']['languages'];
    lnList = []; // clear list
    for (Map<String, dynamic> i in language) {
      lnList.add(Language.fromJson(i));
    }

    // print(dataList);
  }
}
