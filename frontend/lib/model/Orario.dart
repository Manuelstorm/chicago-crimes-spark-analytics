import 'package:flutter/material.dart';
class Orario {
  int value;
  String title;

  Orario({ this.value, this.title});

  factory Orario.fromJson(Map<String, dynamic> json) {
    String titolo="";
    if(json['_2']==0){
      titolo="Mattina";
    }else if(json['_2']==1){
      titolo="Pomeriggio";
    }else if(json['_2']==2){
      titolo="Sera";
    }else{
      titolo="Notte";
    }
    return Orario(
      value: int.parse(json['_1']),
      title: titolo
    );
  }

  @override
  String toString() {
    return title.toString()+value.toString();
  }


}