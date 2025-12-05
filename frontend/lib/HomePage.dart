import 'package:criminaliflutter/components/bar_chart_widget.dart';
import 'package:criminaliflutter/pages/AreaInBar.dart';
import 'package:criminaliflutter/pages/GetAnni.dart';
import 'package:criminaliflutter/pages/GetMesiLine.dart';
import 'package:criminaliflutter/pages/GetTipi.dart';
import 'package:criminaliflutter/pages/Search.dart';
import 'package:criminaliflutter/pages/graficoArea.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/Mese.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Mese> _dati;
  bool _searching = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Color(0xff303030),
            appBar: AppBar(
              backgroundColor: Colors.black54,
              elevation: 0.0,
              centerTitle: true,
              title: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chicago Crimes Stats ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            //fontStyle: FontStyle.italic,
                            fontSize: 24,
                            //color: Color(0xffffffff),
                          ),
                        ),
                        Icon(
                          Icons.bar_chart,
                          size: 30,
                          color: Colors.redAccent,
                        )
                      ],
                    ),
                  ])),
              actions: <Widget>[],
            ),
            //drawer: new Drawer(child: new ListView(children: <Widget>[])),
            bottomNavigationBar: Container(
              color: Color(0xff303030),
              padding: EdgeInsets.only(left: 4.0, right: 4.0),
              height: 44.0 + MediaQuery.of(context).padding.bottom,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //IconButton(icon: Icon(Icons.star)),
                  FittedBox(
                    child: Center(
                        child: Column(children: <Widget>[
                      Text("Site design:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 8)),
                      Text("©Chicago Crimes Stats SRL.",
                          style: TextStyle(fontSize: 8)),
                      Text("MZ - SL - JL", style: TextStyle(fontSize: 8)),
                    ])),
                  ),
                  //IconButton(icon: Icon(Icons.local_police_rounded)),
                ],
              ),
            ),
            body: new ListView(children: <Widget>[
              FittedBox(
                  child: new Container(
                      height: 500.0,
                      width: 1920.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/sfondo5.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: Container(
                            width: 1920,
                            height: 500,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Container(
                                width: 600,
                                height: 300,
                                child: Text(
                                "Questa applicazione offre una piattaforma per eseguire interrogazioni aggregate sul dataset dei crimini di Chicago nel periodo 2001-2019 e visualizzare i risultati in modo grafico. Gli utenti possono filtrare i dati in base a vari criteri come tipo di crimine, luogo, data, ora, e altri parametri pertinenti. Il sito offre anche strumenti per eseguire analisi statistiche sui dati, come la creazione di grafici, tabelle e mappe. Questo permette agli utenti di avere una comprensione più profonda dei crimini commessi nella città di Chicago e di supportare le loro investigazioni e analisi.",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),),
                              Image(
                                  image: AssetImage('images/map_ready.png'),
                                  fit: BoxFit.fill),
                            ])),
                      ))),
              FittedBox(
                  child: Container(
                color: Color(0xff303030),
                height: 100,
                width: 1920.0,
              )),
              FittedBox(
                child: Container(
                  color: Color(0xff303030),
                  child: Row(children: <Widget>[
                    Divider(
                      color: Color(0xff303030),
                      height: 5, //height spacing of divider
                      thickness: 3, //thickness of divier line
                      indent: 25, //spacing at the start of divider
                      endIndent: 25, //spacing at the end of divider
                    ),
                    Container(
                        width: 450,
                        height: 450,
                        child: /*RotatedBox(
                          quarterTurns: 1, // ruota di 90 gradi
                          child:*/
                            GraficoAnni()),
                    Container(
                        color: Color(0xff303030),
                        width: 450,
                        height: 450,
                        child: GraficoTipi()),
                    Container(
                        width: 450, height: 450, child: GraficoMesiLine()),
                    Divider(
                      color: Color(0xff303030),
                      height: 5, //height spacing of divider
                      thickness: 4, //thickness of divier line
                      indent: 25, //spacing at the start of divider
                      endIndent: 25, //spacing at the end of divider
                    ),
                  ]),
                ),
              ),
              FittedBox(
                  child: Container(
                      color: Color(0xff303030), height: 100, width: 1920.0)),
              FittedBox(
                  child: Container(
                      color: Color(0xff303030),
                      height: 800,
                      width: 1920.0,
                      child: Container(
                        height: 100,
                        width: 1920.0,
                        child: SearchBox(),
                      ))),
              FittedBox(
                  child: Container(
                color: Color(0xff303030),
                height: 70,
                width: 1920.0,
              )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ImageWithPoint(),
                    Container(
                      width: 150,
                    ),
                    RotatedBox(
                        quarterTurns: 1, // ruota di 90 gradi
                        child: Container(
                          width: 800 * 0.9,
                          height: 500 * 0.9,
                          child: GraficoAreaBar(),
                        ))
                  ]),
              FittedBox(
                  child: Container(
                      color: Color(0xff303030), height: 100, width: 1920.0)),
            ]))
      ],
    );
  }
}
