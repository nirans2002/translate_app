import 'package:flutter/material.dart';

LnSelectBottomSheet(context, items) {
  String _selectedLn = '';
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(8),
          // height: 200,
          alignment: Alignment.center,
          child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, int) {
                return Divider();
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                    child: Text(items[index].toString()),
                    onTap: () {
                      _selectedLn = items[index];
                      Navigator.of(context).pop();
                    });
              }),
        );
      });
  return _selectedLn;
}
