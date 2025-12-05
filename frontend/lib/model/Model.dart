import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:criminaliflutter/model/Orario.dart';
import 'package:criminaliflutter/utils/rest_manager.dart';

import 'package:http/http.dart';

import 'Anno.dart';
import 'Area.dart';
import 'Mese.dart';
import 'Tipo.dart';


class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();

  Future<List<Tipo>> getCrimeTypes() async {
    Map<String, String> params = Map();
    //params["genre"] = genre;
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/types", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Tipo>.from(json.decode(response.body).map((i) => Tipo.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Area>> getCrimeAreas() async {
    Map<String, String> params = Map();
    //params["genre"] = genre;
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/areas", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Area>.from(json.decode(response.body).map((i) => Area.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Anno>> getCrimeYears() async {
    Map<String, String> params = Map();
    //params["genre"] = genre;
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/years", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Anno>.from(json.decode(response.body).map((i) => Anno.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Mese>> getMonthYears(int anno) async {
    Map<String, String> params = Map();
    params["year"] = anno.toString();
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/months", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Mese>.from(json.decode(response.body).map((i) => Mese.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Anno>> getYearsByType(String tipo) async {
    Map<String, String> params = Map();
    params["tipo"] = tipo;
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/yearsByType", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Anno>.from(json.decode(response.body).map((i) => Anno.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Anno>> getYearsByArea(String area) async {
    Map<String, String> params = Map();
    params["area"] = area;
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/yearsByArea", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Anno>.from(json.decode(response.body).map((i) => Anno.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Mese>> getMonthByArea(String area, int anno) async {
    Map<String, String> params = Map();
    params["area"] = area;
    params["year"] = anno.toString();
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/getMonthByArea", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Mese>.from(json.decode(response.body).map((i) => Mese.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Mese>> getMonthByType(String tipo, int anno) async {
    Map<String, String> params = Map();
    params["tipo"] = tipo;
    params["year"] = anno.toString();
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/getMonthByType", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Mese>.from(json.decode(response.body).map((i) => Mese.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Tipo>> getTypesByArea(String area) async {
    Map<String, String> params = Map();
    params["area"] = area;
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/getTypesByArea", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Tipo>.from(json.decode(response.body).map((i) => Tipo.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Orario>> getOrariByType(String tipo) async {
    Map<String, String> params = Map();
    params["tipo"] = tipo;
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/getOrariByType", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Orario>.from(json.decode(response.body).map((i) => Orario.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Area>> getAreasMap() async {
    Map<String, String> params = Map();
    try{
      Response response = await _restManager.makeGetRequest("localhost:8180", "/getAreas", params);
      if( response.statusCode == HttpStatus.notFound ) return null;
      return List<Area>.from(json.decode(response.body).map((i) => Area.fromJson(i)).toList());
    }
    catch (e) {
      print(e);
      return null;
    }
  }



}
