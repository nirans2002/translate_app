import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

Future<dynamic> language_select_show_bottom_sheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Color.fromRGBO(20, 20, 20, 0.5),
      barrierColor: Colors.black45,
      builder: (context) {
        return GlassContainer(
          // height: ,
          blur: 3,
          shadowStrength: 20,
          opacity: 0.05,
          width: max(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
          borderRadius: BorderRadius.circular(40),
          child: Center(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Text('English'),
                Text('Hindi'),
                Text('Marathi'),
                Text('Gujarati'),
              ],
            ),
          ),
        );
      });
}
