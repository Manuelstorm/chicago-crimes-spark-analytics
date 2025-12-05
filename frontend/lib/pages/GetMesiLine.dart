import 'package:criminaliflutter/components/line_chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/bar_chart_widget.dart';
import '../model/Mese.dart';
import '../model/Model.dart';

class GraficoMesiLine extends StatefulWidget {
  const GraficoMesiLine({Key key}) : super(key: key);

  @override
  _GraficoMesiLineState createState() => _GraficoMesiLineState();
}

class _GraficoMesiLineState extends State<GraficoMesiLine> {
  int year = 2011;
  List<Mese> dati;
  bool datiOttenuti = false;
  LineChartWidget grafico = null;

  @override
  void initState() {
    _getData();
    grafico = LineChartWidget(dati);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Row(
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
                  _getData();
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
        ),
        datiOttenuti
            ? Expanded(
                child: Container(
                  child: grafico,
                  width: 500,
                  height: 500,
                ),
              )
            : CircularProgressIndicator()
      ],
    ));
  }

  Future<void> _getData() async {
    setState(() {
      datiOttenuti = false;
      dati = null;
    });
    Model.sharedInstance.getMonthYears(year).then((result) {
      setState(() {
        datiOttenuti = true;
        dati = result;
        grafico = LineChartWidget(dati);
      });
    });
  }
}
