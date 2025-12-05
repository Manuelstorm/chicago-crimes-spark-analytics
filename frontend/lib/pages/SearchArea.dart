import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/bar_chart_widget.dart';
import '../components/line_chart_widget.dart';
import '../components/pie_chart_widget.dart';
import '../model/Anno.dart';
import '../model/Mese.dart';
import '../model/Model.dart';
import '../model/Tipo.dart';

class SearchArea extends StatefulWidget {
  const SearchArea({Key key}) : super(key: key);

  @override
  State<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  int area = 1;
  bool datiOttenuti = false;
  List<Anno> dati;
  List<Mese> dati2;
  List<Tipo> dati3;
  Widget grafico = null;
  int tipoDiGrafico = 1;
  int year = 2003;

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
                  Text('Per tipo',
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
                    value: area.toDouble(),
                    max: 77,
                    min: 1,
                    divisions: 77,
                    label: area.toString(),
                    onChanged: (double value) {
                      setState(() {
                        area = value.toInt();
                      });
                    },
                    onChangeEnd: (double value) {
                      initState();
                    },
                  ),
                )),
            Container(
                width: 25,
                color: Colors.black26,
                child: Text(
                  area.toString(),
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
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

  Future<void> _getData() async {
    setState(() {
      datiOttenuti = false;
      dati = null;
    });
    if(tipoDiGrafico == 1) {
      (Model.sharedInstance.getYearsByArea(area.toString()).then((result) {
        setState(() {
          datiOttenuti = true;
          dati = result;
          grafico = BarChartWidget(dati);
        });
      }));
    }
        else if(tipoDiGrafico==2) {
      Model.sharedInstance.getMonthByArea(area.toString(), year).then((result) {
        setState(() {
          datiOttenuti = true;
          dati2 = result;
          grafico = LineChartWidget(dati2);
        });
      });
    }else{
      Model.sharedInstance.getTypesByArea(area.toString()).then((result) {
        setState(() {
          datiOttenuti = true;
          dati3 = result;
          grafico = PieChartWidget(dati3);
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
