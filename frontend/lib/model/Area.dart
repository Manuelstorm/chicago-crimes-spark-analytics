import 'package:flutter/material.dart';
class Area {
  int title;
  double value;

  Area({ this.value, this.title});

  factory Area.fromJson(Map<String, dynamic> json) {
    if(json['Community Area']==null){
      return Area(
          title: -1,
          value: json['count']
      );
    }
    return Area(
        title: json['Community Area'],
        value: json['count']
    );
  }

  Map<String, dynamic> toJson() => {
    'Community Area': title,
    'count': value,

  };

  @override
  String toString() {
    return title.toString()+value.toString();
  }


}