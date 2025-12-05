import 'package:flutter/material.dart';

import 'HomePage.dart';

void main(){
  runApp(
      new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          theme: ThemeData.dark()//ThemeData(textTheme:TextTheme(headline2: TextStyle(color: Colors.deepPurpleAccent)))
      )
  );
}
