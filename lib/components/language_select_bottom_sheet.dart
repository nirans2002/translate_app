import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:translate_app/models/languages.dart';

List<Language> dataList = [];

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
    dataList = []; // clear list
    for (Map<String, dynamic> i in language) {
      dataList.add(Language.fromJson(i));
    }

    // print(dataList);
  }
}

Future<dynamic> language_select_show_bottom_sheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Color.fromRGBO(20, 20, 20, 0.5),
      barrierColor: Colors.black45,
      builder: (context) {
        return BottomSheet();
      });
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  bool is_loading = false;
  // @override
  // initState() {
  //   super.initState();
  //   is_loading = true;
  //   getData();
  //   is_loading = false;
  // }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      // height: ,
      blur: 3,
      shadowStrength: 20,
      opacity: 1,
      width: max(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      borderRadius: BorderRadius.circular(10),
      child: Center(
        child: is_loading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, i) {
                  final language = dataList[i];
                  return ListTile(
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      language.language.toString(),
                    ),
                  );
                }),
      ),
    );
  }
}
