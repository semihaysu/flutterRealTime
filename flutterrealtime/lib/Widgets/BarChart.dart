import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class BarChartSample extends StatefulWidget {
  const BarChartSample({required this.data});
  final Map<String, int> data;

  @override
  _BarChartSampleState createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  int touchedIndex = -1;

  List<Color> barColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
    Colors.amber,
    Colors.deepPurple,
    Colors.cyan,
    Colors.deepOrange,
    Colors.indigo,
    Colors.lime,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.deepPurpleAccent,
    Colors.amberAccent,
    Colors.brown
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2,
      height: MediaQuery.of(context).size.height * 0.5,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String key = widget.data.keys.toList()[group.x.toInt()];
                int value = widget.data.values.toList()[group.x.toInt()];
                return BarTooltipItem(
                    '$key\nDeğer: $value',
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ));
              },
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: showingBarGroups(),
          groupsSpace: 100,
        ),
      ),
    );
  }

  List<BarChartGroupData> showingBarGroups() {
    return List.generate(widget.data.length, (i) {
      if (widget.data.values.toList()[i] > 0) {
        return BarChartGroupData(
          barsSpace: 1,
          x: i,
          barRods: [
            BarChartRodData(
              toY: widget.data.values.toList()[i].toDouble(),
              color: barColors[i % barColors.length],
              width: 8,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
          ],
        );
      } else {
        return BarChartGroupData(x: i, barRods: []);
      }
    });
  }
}
