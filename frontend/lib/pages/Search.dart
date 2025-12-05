import 'package:criminaliflutter/pages/GetTipi.dart';
import 'package:criminaliflutter/pages/SearchArea.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SearchTipo.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String dropdownvalue = 'Tipo';

  var items = [
    'Tipo',
    'Community Area',
    'Data',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Effettua ricerca per ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),

                      onChanged: (Object obj) {
                        setState(() {
                          dropdownvalue = obj;
                        });
                      },
                    ),
                  ],
                ),
                bottom(),

              ])),
    );
  }


  Widget bottom() {
    switch (dropdownvalue){
      case 'Tipo':
        return SearchTipo();
      case  'Community Area':
        return SearchArea();
      case  'Data':
        return Container();
    }
    }
}