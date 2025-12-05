import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/Mese.dart';



class LineChartWidget extends StatelessWidget {
  final List<Mese> points;

  const LineChartWidget(this.points, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.black12,
          lineBarsData: [
            LineChartBarData(
                spots: points.map((point) => FlSpot(double.parse(point.title), point.value)).toList(),
                isCurved: false,
                dotData: FlDotData(
                  show: false,
                ),
                color: Colors.red,
            ),
          ],
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineTouchData: LineTouchData(
              enabled: true,
              touchCallback:
                  (FlTouchEvent event, LineTouchResponse touchResponse) {
              },
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.redAccent,
                tooltipRoundedRadius: 20.0,
                showOnTopOfTheChartBoxArea: true,
                fitInsideHorizontally: true,
                tooltipMargin: 0,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map(
                        (LineBarSpot touchedSpot) {
                      const textStyle = TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      );
                      return LineTooltipItem(
                        points[touchedSpot.spotIndex].value.toStringAsFixed(0),
                        textStyle,
                      );
                    },
                  ).toList();
                },
              ),
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> indicators) {
                return indicators.map(
                      (int index) {
                    final line = FlLine(
                        color: Colors.grey,
                        strokeWidth: 1,
                        dashArray: [2, 4]);
                    return TouchedSpotIndicatorData(
                      line,
                      FlDotData(show: false),
                    );
                  },
                ).toList();
              },
              getTouchLineEnd: (_, __) => double.infinity
          ),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 1:
          text = 'Jan';
          break;
        case 2:
          text = 'Feb';
          break;
        case 3:
          text = 'Mar';
          break;
        case 4:
          text = 'Apr';
          break;
        case 5:
          text = 'May';
          break;
        case 6:
          text = 'Jun';
          break;
        case 7:
          text = 'Jul';
          break;
        case 8:
          text = 'Aug';
          break;
        case 9:
          text = 'Sep';
          break;
        case 10:
          text = 'Oct';
          break;
        case 11:
          text = 'Nov';
          break;
        case 12:
          text = 'Dec';
          break;
      }

      return Text(text);
    },
  );
}