import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/bar_chart_area.dart';
import '../components/bar_chart_widget.dart';
import '../model/Anno.dart';
import '../model/Area.dart';
import '../model/Model.dart';

class GraficoAreaBar extends StatefulWidget {
  const GraficoAreaBar({Key key}) : super(key: key);

  @override
  _GraficoAreaBarState createState() => _GraficoAreaBarState();
}

class _GraficoAreaBarState extends State<GraficoAreaBar> {
  List<Area> dati;
  bool datiOttenuti = false;
  BarChartArea grafico = null;

  @override
  void initState() {
    _getData();
    grafico = BarChartArea(dati);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return datiOttenuti
        ? Expanded(
      child: Container(
        child: grafico,
      ),
    )
        : CircularProgressIndicator();
  }

  Future<void> _getData() async {
    setState(() {
      datiOttenuti = false;
      dati = null;
    });
    Model.sharedInstance.getAreasMap().then((result) {
      setState(() {
        datiOttenuti = true;
        dati = result;
        grafico = BarChartArea(dati);
      });
    });
  }
}
