import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/Anno.dart';
import '../model/Mese.dart';
//import 'package:flutter_chart_demo/data/price_point.dart';

class BarChartWidget extends StatefulWidget {
  final List<Anno> points;

  const BarChartWidget(
    this.points, {
    Key key,
  }) : super(key: key);

  @override
  State<BarChartWidget> createState() =>
      _BarChartWidgetState(points: this.points);
}

class _BarChartWidgetState extends State<BarChartWidget> {
  final List<Anno> points;

  _BarChartWidgetState({this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: 1,
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
