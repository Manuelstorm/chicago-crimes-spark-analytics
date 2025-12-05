import 'package:flutter/material.dart';
class Tipo {
  String title;
  double value;

  Tipo({ this.value, this.title});

  factory Tipo.fromJson(Map<String, dynamic> json) {
    return Tipo(
      title: json['Primary Type'],
      value: json['count']
    );
  }

  Map<String, dynamic> toJson() => {
    'Primary Type': title,
    'count': value,

  };

  @override
  String toString() {
    return title+value.toString();
  }


}