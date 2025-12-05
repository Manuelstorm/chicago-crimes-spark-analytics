import 'package:criminaliflutter/model/Orario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/bar_chart_widget.dart';
import '../components/line_chart_widget.dart';
import '../components/pie_chart_orario.dart';
import '../components/pie_chart_widget.dart';
import '../model/Anno.dart';
import '../model/Mese.dart';
import '../model/Model.dart';
import '../model/Tipo.dart';

class SearchTipo extends StatefulWidget {
  const SearchTipo({Key key}) : super(key: key);

  @override
  State<SearchTipo> createState() => _SearchTipoState();
}

class _SearchTipoState extends State<SearchTipo> {
  int tipo = 1;
  int year = 2018;
  bool datiOttenuti = false;
  List<Anno> dati;
  List<Mese> dati2;
  List<Orario> dati3;
  Widget grafico = null;
  int tipoDiGrafico = 1;

  @override
  void initState() {
    _getData();
    grafico = BarChartWidget(dati);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Column(
        children: [
          InkWell(
              child: Row(
                children: [
                  Text('Per anno',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            tipoDiGrafico == 1 ? Colors.redAccent : Colors.grey,
                      )),
                  Icon(
                    Icons.bar_chart,
                    size: 20,
                    color: tipoDiGrafico == 1 ? Colors.redAccent : Colors.grey,
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  tipoDiGrafico = 1;
                });
                _getData();
              }),
          InkWell(
              child: Row(
                children: [
                  Text(
                    'Per mese',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          tipoDiGrafico == 2 ? Colors.redAccent : Colors.grey,
                    ),
                  ),
                  Icon(
                    Icons.stacked_line_chart_outlined,
                    size: 20,
                    color: tipoDiGrafico == 2 ? Colors.redAccent : Colors.grey,
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  tipoDiGrafico = 2;
                });
                _getData();
              }),
          InkWell(
              child: Row(
                children: [
                  Text('Per orario',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            tipoDiGrafico == 3 ? Colors.redAccent : Colors.grey,
                      )),
                  Icon(
                    Icons.pie_chart,
                    size: 20,
                    color: tipoDiGrafico == 3 ? Colors.redAccent : Colors.grey,
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  tipoDiGrafico = 3;
                });
                _getData();
              }),
        ],
      ),
      Container(
        width: 50,
      ),
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 400,
                child: Flexible(
                  child: Slider(
                    activeColor: Colors.redAccent,
                    value: tipo.toDouble(),
                    max: 35,
                    min: 1,
                    divisions: 35,
                    label: tipoFromInt(),
                    onChanged: (double value) {
                      setState(() {
                        tipo = value.toInt();
                      });
                    },
                    onChangeEnd: (double value) {
                      _getData();
                      initState();
                    },
                  ),
                )),
            Container(
                width: 130,
                color: Colors.black26,
                child: Text(
                  tipoFromInt(),
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
        Container(
            width: 400,
            child: tipoDiGrafico == 2 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Slider(
                    activeColor: Colors.redAccent,
                    value: year.toDouble(),
                    max: 2019,
                    min: 2001,
                    divisions: 19,
                    label: year.toString(),
                    onChanged: (double value) {
                      setState(() {
                        year = value.toInt();
                      });
                    },
                    onChangeEnd: (double value) {
                      initState();
                    },
                  ),
                ),
                FittedBox(
                    child: Container(
                        color: Colors.black26,
                        child: Text(
                          year.toString(),
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )))
              ],
            ) : Container()
        ),
        bottom(),
      ])
    ]));
  }

  tipoFromInt() {
    List<String> lista = [
      "OFFENSE INVOLVING CHILDREN",
      "CRIMINAL SEXUAL ASSAULT",
      "STALKING",
      "PUBLIC PEACE VIOLATION",
      "OBSCENITY",
      "NON-CRIMINAL (SUBJECT SPECIFIED)",
      "ARSON",
      "GAMBLING",
      "CRIMINAL TRESPASS",
      "ASSAULT",
      "NON - CRIMINAL",
      "LIQUOR LAW VIOLATION",
      "MOTOR VEHICLE THEFT",
      "THEFT",
      "BATTERY",
      "ROBBERY",
      "HOMICIDE",
      "PUBLIC INDECENCY",
      "CRIM SEXUAL ASSAULT",
      "HUMAN TRAFFICKING",
      "INTIMIDATION",
      "PROSTITUTION",
      "DECEPTIVE PRACTICE",
      "CONCEALED CARRY LICENSE VIOLATION",
      "SEX OFFENSE",
      "CRIMINAL DAMAGE",
      "NARCOTICS",
      "NON-CRIMINAL",
      "OTHER OFFENSE",
      "KIDNAPPING",
      "BURGLARY",
      "WEAPONS VIOLATION",
      "OTHER NARCOTIC VIOLATION",
      "INTERFERENCE WITH PUBLIC OFFICER",
      "DOMESTIC VIOLENCE",
      "RITUALISM"
    ];
    return lista[tipo];
  }

  Future<void> _getData() async {
    setState(() {
      datiOttenuti = false;
      dati = null;
    });
    if(tipoDiGrafico == 1) {
      Model.sharedInstance.getYearsByType(tipoFromInt()).then((result) {
        setState(() {
          datiOttenuti = true;
          dati = result;
          grafico = BarChartWidget(dati);
        });
      });
    }else if(tipoDiGrafico==2) {
      Model.sharedInstance.getMonthByType(tipoFromInt(), year).then((result) {
        setState(() {
          datiOttenuti = true;
          dati2 = result;
          grafico = LineChartWidget(dati2);
        });
      });
    }else{
      Model.sharedInstance.getOrariByType(tipoFromInt()).then((result) {
        setState(() {
          datiOttenuti = true;
          dati3 = result;
          grafico = PieChartOrario(dati3);
        });
      });
    }
  }

  bottom() {
    return datiOttenuti
        ? Container(
            child: grafico,
            width: 500,
            height: 500,
          )
        : CircularProgressIndicator();
  }
}
