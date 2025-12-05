import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/Anno.dart';
import '../model/Area.dart';
import '../model/Mese.dart';
//import 'package:flutter_chart_demo/data/price_point.dart';

class BarChartArea extends StatefulWidget {
  final List<Area> points;

  const BarChartArea(
      this.points, {
        Key key,
      }) : super(key: key);

  @override
  State<BarChartArea> createState() =>
      _BarChartAreaState(points: this.points);
}

class _BarChartAreaState extends State<BarChartArea> {
  final List<Area> points;

  _BarChartAreaState({this.points});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BarChart(
        BarChartData(
          //alignment: BarChartAlignment.center,
          barGroups: _chartGroups(),
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value,meta) {
                  return RotatedBox(
                    quarterTurns: 3, // ruota di 90 gradi
                    child: Text(
                      value.toString(),
                      style: TextStyle(fontSize: 9),
                    ),
                  );

                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: _bottomTitles),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    return points
        .map((point) => BarChartGroupData(
        x: point.title, barRods: [
      BarChartRodData(color: Colors.redAccent, toY: point.value)
    ]))
        .toList();
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      return RotatedBox(
        quarterTurns: 3, // ruota di 90 gradi
        child: Text(
          value.toString(),
          style: TextStyle(fontSize: 9),
        ),
      );
    },
  );

}
/*
class PricePoint {
  double x;
  double y;

  PricePoint(this.x,this.y);
}

 */
