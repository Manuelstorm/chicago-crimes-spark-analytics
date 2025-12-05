import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/bar_chart_widget.dart';
import '../model/Anno.dart';
import '../model/Model.dart';

class GraficoAnni extends StatefulWidget {
  const GraficoAnni({Key key}) : super(key: key);

  @override
  _GraficoAnniState createState() => _GraficoAnniState();
}

class _GraficoAnniState extends State<GraficoAnni> {
  List<Anno> dati;
  bool datiOttenuti = false;
  BarChartWidget grafico = null;

  @override
  void initState() {
    _getData();
    grafico = BarChartWidget(dati);

    super.initState();
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
    Model.sharedInstance.getCrimeYears().then((result) {
      setState(() {
        datiOttenuti = true;
        dati = result;
        grafico = BarChartWidget(dati);
      });
    });
  }
}
