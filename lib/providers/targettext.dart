import 'package:flutter/material.dart';
import 'package:translate_app/services/translate.dart';

class TargetText extends ChangeNotifier {
  String _text = '';

  String get getText {
    return _text;
  }

  void updateText() {
    // _text = translate(source, target, query);
    _text = _text + "ww";
    notifyListeners();
  }
}
