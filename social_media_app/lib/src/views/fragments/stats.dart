import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: camel_case_types
class Statistics extends StatefulWidget {
  //const stats({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

var titleList = [
  "Punjab",
  "Ghaziabad",
  "South Delhi",
  "Moradabad",
  "Allahabad",
  "Lucknow",
  "Pune",
  "Mumbai",
  "Himachal",
  "Haryana"
];
var imageList = [
  "images/login.png",
  "images/login.png",
  "images/login.png",
  "images/login.png",
  "images/login.png",
  "images/login.png",
  "images/login.png",
  "images/login.png",
  "images/login.png",
  "images/login.png"
];

// ignore: camel_case_types
class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: titleList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return GraphPlot();
            })),
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 120,
                    child: Image.asset(imageList[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          titleList[index],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GraphPlot extends StatefulWidget {
  @override
  _GraphPlotState createState() => _GraphPlotState();
}

class _GraphPlotState extends State<GraphPlot> {
  List<GraphData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCircularChart(
      title: ChartTitle(text: 'Title'),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        RadialBarSeries<GraphData, String>(
            dataSource: _chartData,
            xValueMapper: (GraphData data, _) => data.graphFactors,
            yValueMapper: (GraphData data, _) => data.graphValue,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
            maximumValue: 40000)
      ],
    )));
  }

  List<GraphData> getChartData() {
    final List<GraphData> chartData = [
      GraphData('Closed Issues', 2900),
      GraphData('Active Issues', 23050),
      GraphData('Total Issues Created', 24880),
      GraphData('Active NGOs', 24880),
      GraphData('Active Users', 34390),
    ];
    return chartData;
  }
}

class GraphData {
  GraphData(this.graphFactors, this.graphValue);
  final String graphFactors;
  final int graphValue;
}
