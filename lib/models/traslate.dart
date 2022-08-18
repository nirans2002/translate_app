import 'dart:convert';

List<Translation> modelUserFromJson(String str) => List<Translation>.from(
    json.decode(str).map((x) => Translation.fromJson(x)));

String modelUserToJson(List<Translation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Translation {
  String translation;

  Translation({
    required this.translation,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        translation: json["translatedText"],
      );

  Map<String, dynamic> toJson() => {
        "translatedText": translation,
      };
}
