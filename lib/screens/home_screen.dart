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
  String fromLn = 'From Language';
  String toLn = 'To Language';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2, child: LnSelectButton(context, fromLn, true)),
                  Expanded(
                    flex: 1,
                    child: const SizedBox(
                      width: 10,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                  Expanded(
                      flex: 2, child: LnSelectButton(context, toLn, false)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Enter Text to be translated',
                ),
              ),
            ),
            Container(
              child: Text('Hello',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  InkWell LnSelectButton(BuildContext context, String ln, bool isFrom) {
    return InkWell(
      onTap: () {
        showModal(context, isFrom);
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

  void showModal(context, bool isFrom) {
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
                          isFrom
                              ? fromLn = lnList[index].language.toString()
                              : toLn = lnList[index].language.toString();
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
