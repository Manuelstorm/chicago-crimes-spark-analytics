import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_chart_demo/data/sector.dart';
import 'dart:math' as math;

import '../model/Orario.dart';

class PieChartOrario extends StatefulWidget {
  final List<Orario> sectors;

  const PieChartOrario(
      this.sectors, {
        Key key,
      }) : super(key: key);

  @override
  State<PieChartOrario> createState() =>
      _PieChartOrarioState(this.sectors);
}

class _PieChartOrarioState extends State<PieChartOrario> {
  final List<Orario> sectors;
  int touchedIndex=-1;

  _PieChartOrarioState(this.sectors);


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0,
        child: PieChart( PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse
                    .touchedSection.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          sections: _chartSections(sectors),
          centerSpaceRadius: 85.0,
        )));
  }

  List<PieChartSectionData> _chartSections(List<Orario> sectors) {
    final List<PieChartSectionData> list = [];
    final List<Color> colors=[//Color(0xfffcba03), Color(0xff03dffc),
      Color(0xff2a52be), Color(0xff00cc99), Colors.red, Colors.green];
    int index=0;
    for (var sector in sectors) {
      //const double radius = 75.0;
      final isTouched = index == touchedIndex;
      final dimensione = isTouched ? 25.0 : 14.0;
      final radius = isTouched ? 90.0 : 75.0;
      final data = PieChartSectionData(
          color: colors[index]
              .withOpacity(0.8),
          value: sector.value.toDouble(),
          radius: radius,
          title: isTouched ? sector.value.toString() : sector.title,
          titleStyle: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: dimensione,
          ));
      list.add(data);
      index++;
      if(index==6) index=0;
    }
    return list;
  }
}
