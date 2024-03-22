import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({required this.data});
  final Map<String, int> data;

  @override
  _PieChartSample2State createState() => _PieChartSample2State();
}

class _PieChartSample2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  bool showData = true;

  List<Color> colors = [
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: showData
          ? MediaQuery.of(context).size.height * 0.8
          : MediaQuery.of(context).size.height * 0.6,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                      } else {
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      }
                    });
                  },
                ),
                borderData: FlBorderData(show: true),
                sectionsSpace: 2,
                centerSpaceRadius: MediaQuery.of(context).size.width * 0.001,
                sections: showingSections(),
              ),
            ),
          ),
          SizedBox(height: 10),
          IconButton(
            onPressed: () {
              setState(() {
                showData =
                    !showData; // Butona her basıldığında showData değerini tersine çevirir.
              });
            },
            icon: showData
                ? Icon(
                    Icons.arrow_drop_up,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  )
                : Icon(Icons.arrow_drop_down,
                    color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          Visibility(
            visible: showData,
            child: Column(
              children: [
                Text(
                  'Veriler:',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 5),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: widget.data.keys.map((key) {
                    int index = widget.data.keys.toList().indexOf(key);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          touchedIndex = index;
                        });
                        print(' $key, Değer: ${widget.data[key]}');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            color: colors[index],
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '$key',
                            style: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.data.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 18 : 16;
      final double radius = isTouched ? 100 : 90;

      return PieChartSectionData(
        color: colors[i],
        value: widget.data.values.toList()[i].toDouble(),
        title: '${widget.data.values.toList()[i].toStringAsFixed(0)}',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isTouched ? Colors.black : Colors.white,
        ),
      );
    });
  }
}
