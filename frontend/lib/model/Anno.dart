import 'package:flutter/material.dart';
class Anno {
  int title;
  double value;

  Anno({ this.value, this.title});

  factory Anno.fromJson(Map<String, dynamic> json) {
    if(json['Year']==null){
      return Anno(
          title: 0,
          value: json['count']
      );
    }
    return Anno(
        title: json['Year'],
        value: json['count']
    );
  }

  Map<String, dynamic> toJson() => {
    'Year': title,
    'count': value,

  };

  @override
  String toString() {
    return title.toString()+value.toString();
  }


}