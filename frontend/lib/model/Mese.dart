import 'package:flutter/material.dart';
class Mese {
  String title;
  double value;

  Mese({ this.value, this.title});

  factory Mese.fromJson(Map<String, dynamic> json) {
    if(json['Date']==null){
      return Mese(
          title: "00",
          value: json['count']
      );
    }
    return Mese(
        title: json['Date'],
        value: json['count']
    );
  }

  Map<String, dynamic> toJson() => {
    'Date': title,
    'count': value,

  };

  @override
  String toString() {
    return title.toString()+value.toString();
  }


}