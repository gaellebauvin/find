import 'package:firebase_database/firebase_database.dart';

class Find {
  String? uid;
  bool? find;
  List<String>? category;
  String? address;
  DateTime? date;
  String? hours;
  String? model;
  String? brand;
  String? color;
  String? description;

  Find.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        model = json['model'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date.toString(),
        'model': model,
      };
}
