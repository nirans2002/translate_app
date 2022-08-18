import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:translate_app/components/language_select_bottom_sheet.dart';
import 'package:translate_app/models/languages.dart';
import 'package:translate_app/services/get_lan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fromLn = 'Select Language';
  String toLn = 'Select Language';
  List<Language> lnList = [];

  Future getData() async {
    final responseData = await http.get(
        Uri.parse(
            'https://google-translate1.p.rapidapi.com/language/translate/v2/languages'),
        headers: {
          'Accept-Encoding': "application/gzip",
          'X-RapidAPI-Key':
              "21b2cc4651msha46a43a31fc93f2p11c402jsnee93d4687d68",
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // print(lnList[0].language.toString());
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Translate App',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LnSelectButton(context, fromLn),
                LnSelectButton(context, toLn),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell LnSelectButton(BuildContext context, String ln) {
    return InkWell(
      onTap: () {
        showModal(context);
      },
      child: Card(
        color: Colors.blueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              ln,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: lnList.length,
                separatorBuilder: (context, int) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Text(lnList[index].language.toString()),
                      onTap: () {
                        setState(() {
                          fromLn = lnList[index].language.toString();
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
