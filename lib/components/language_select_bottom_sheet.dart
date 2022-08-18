import 'package:flutter/material.dart';

void showModal(context, lnList) {
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
                      // setState(() {
                      //   fromLn = lnList[index].language.toString();
                      // });
                      Navigator.of(context).pop();
                    });
              }),
        );
      });
}
