import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({required this.data});
  final Map<String, int> data;

  @override
  _PieChartSample3State createState() => _PieChartSample3State();
}

class _PieChartSample3State extends State<PieChartSample3> {
  List<Color> colorList = [
   Colors.blue,
Colors.green,
Colors.red,
Colors.yellow,
Colors.purple,
Colors.orange,
Colors.teal,
Colors.pink,
Colors.amber,
Colors.white54,
Colors.deepPurple,
Colors.cyan,
Colors.deepOrange,
Colors.indigo,
Colors.lime,
Colors.lightBlue,
Colors.lightGreen,
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, double> convertedData = Map.from(widget.data).map((key, value) => MapEntry(key, value.toDouble()));
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart Example'),
      ),
      body: Center(
        child: PieChart(
          dataMap: convertedData,
          colorList: colorList,
          chartType: ChartType.disc,
          legendOptions: LegendOptions(legendPosition: LegendPosition.bottom , showLegendsInRow: true),
          chartRadius: MediaQuery.of(context).size.width / 2,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: false,
            
          ),
        ),
      ),
    );
  }
}
