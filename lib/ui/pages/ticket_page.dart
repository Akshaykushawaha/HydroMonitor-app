import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../app/configs/colors.dart';

class TemperatureChartPage extends StatefulWidget {
  @override
  _TemperatureChartPageState createState() => _TemperatureChartPageState();
}

class _TemperatureChartPageState extends State<TemperatureChartPage> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Temperature Records'),
      ),
      body: AspectRatio(
        aspectRatio: 0.55,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                const Text(
                  'Showing data for past few hours',
                  style: TextStyle(
                    color: Colors.black, // Use your app's color here
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart(isShowingMainData: isShowingMainData),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Showing data for the past 4 days',
                  style: TextStyle(
                    color: Colors.black, // Use your app's color here
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart1(isShowingMainData: false),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    backgroundColor: Colors.grey[200],
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 14,
    maxY: 40, // Modify the maximum temperature value as needed
    minY: 0,
  );

  LineChartData get sampleData2 => LineChartData(
    lineTouchData: lineTouchData2,
    backgroundColor: Colors.blueGrey,
    gridData: gridData,
    titlesData: titlesData2,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0.5,
    maxX: 14,
    maxY: 9, // Modify the maximum temperature value as needed
    minY: 00,
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_3,
  ];

  LineTouchData get lineTouchData2 => const LineTouchData(
    enabled: false,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '20°C'; // Modify temperature labels as needed
        break;
      case 3:
        text = '23°C'; // Modify temperature labels as needed
        break;
      case 6:
        text = '26°C'; // Modify temperature labels as needed
        break;
      case 9:
        text = '29°C'; // Modify temperature labels as needed
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 3,
    reservedSize: 35,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0:00';
        break;

      case 4:
        text = '4:30';
        break;

      case 8:
        text = '8:30';
        break;

      case 12:
        text = '12:30';
        break;

      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }


  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: Colors.white.withOpacity(0.2), width: 4),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorCyan,

    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: true),
    spots: const [
        FlSpot(1, 2), // Modify temperature data as needed
        FlSpot(2, 2), // Modify temperature data as needed
        FlSpot(3, 3), // Modify temperature data as needed
        FlSpot(4, 3), // Modify temperature data as needed
        FlSpot(5, 3), // Modify temperature data as needed
        FlSpot(6, 4), // Modify temperature data as needed
        FlSpot(7, 5), // Modify temperature data as needed
        FlSpot(8,5), // Modify temperature data as needed
        FlSpot(9, 4), // Modify temperature data as needed
        FlSpot(10, 4), // Modify temperature data as needed
        FlSpot(11, 4), // Modify temperature data as needed
        FlSpot(12, 4), // Modify temperature data as needed
        FlSpot(13, 4), // Modify temperature data as needed
    ],
  );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Plant Temperature Records',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(isShowingMainData: isShowingMainData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }
}

class _LineChart1 extends StatelessWidget {
  const _LineChart1({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
    lineTouchData: lineTouchData1,
    backgroundColor: Colors.grey[200],
    gridData: gridData,
    titlesData: titlesData1,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0,
    maxX: 14,
    maxY: 40, // Modify the maximum temperature value as needed
    minY: 0,
  );

  LineChartData get sampleData2 => LineChartData(
    lineTouchData: lineTouchData2,
    backgroundColor: Colors.blueGrey,
    gridData: gridData,
    titlesData: titlesData2,
    borderData: borderData,
    lineBarsData: lineBarsData1,
    minX: 0.5,
    maxX: 11,
    maxY: 9, // Modify the maximum temperature value as needed
    minY: 00,
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_3,
  ];

  LineTouchData get lineTouchData2 => const LineTouchData(
    enabled: false,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '20°C'; // Modify temperature labels as needed
        break;
      case 3:
        text = '23°C'; // Modify temperature labels as needed
        break;
      case 6:
        text = '26°C'; // Modify temperature labels as needed
        break;
      case 9:
        text = '29°C'; // Modify temperature labels as needed
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 3,
    reservedSize: 35,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '2nd OCT';
        break;
      case 4:
        text = '3rd OCT';
        break;
      case 7:
        text = '4th OCT';
        break;
      case 10:
        text = '5th OCT';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }


  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: Colors.white.withOpacity(0.2), width: 4),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorCyan,

    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: true),
    spots: const [
      FlSpot(1, 5), // Modify temperature data as needed
      FlSpot(2, 4), // Modify temperature data as needed
      FlSpot(3, 4), // Modify temperature data as needed
      FlSpot(4, 4), // Modify temperature data as needed
      FlSpot(5, 5), // Modify temperature data as needed
      FlSpot(6, 5), // Modify temperature data as needed
      FlSpot(7, 5), // Modify temperature data as needed
      FlSpot(8, 5), // Modify temperature data as needed
      FlSpot(9, 5), // Modify temperature data as needed
      FlSpot(10,6), // Modify temperature data as needed
    ],

  );
}

class LineChartSample11 extends StatefulWidget {
  const LineChartSample11({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State1 extends State<LineChartSample1> {
  late bool isShowingMainData1;

  @override
  void initState() {
    super.initState();
    isShowingMainData1 = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Plant Temperature Records',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(isShowingMainData: isShowingMainData1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white.withOpacity(isShowingMainData1 ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData1 = !isShowingMainData1;
              });
            },
          )
        ],
      ),
    );
  }
}