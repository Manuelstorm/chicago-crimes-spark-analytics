import 'package:criminaliflutter/components/pie_chart_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/bar_chart_widget.dart';
import '../model/Model.dart';
import '../model/Tipo.dart';

class GraficoTipi extends StatefulWidget {
  const GraficoTipi({Key key}) : super(key: key);

  @override
  _GraficoTipiState createState() => _GraficoTipiState();
}

class _GraficoTipiState extends State<GraficoTipi> {
  List<Tipo> dati;
  bool datiOttenuti = false;
  //BarChartWidget grafico = null;
  PieChartWidget grafico = null;

  @override
  void initState() {
    //super.initState();
    _getData().then((value) => grafico = PieChartWidget(dati));
  }

  @override
  Widget build(BuildContext context) {
    return datiOttenuti
        ? Expanded(
            child: Container(
              child: grafico,
              width: 500,
              height: 500,
            ),
          )
        : CircularProgressIndicator();
  }

  Future<void> _getData() async {
    setState(() {
      datiOttenuti = false;
      dati = null;
    });
    Model.sharedInstance.getCrimeTypes().then((result) {
      setState(() {
        datiOttenuti = true;
        dati = result;
        grafico = PieChartWidget(dati);
      });
    });
  }
}
