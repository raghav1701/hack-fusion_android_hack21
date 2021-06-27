import 'dart:math';
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
  "Mumbai"
];
var imageList = [
  "images/punjab.jpeg",
  "images/ghaziabad.jpeg",
  "images/delhi.jpeg",
  "images/chennai.jpeg",
  "images/allahabad.jpeg",
  "images/lucknow.jpeg",
  "images/pune.png",
  "images/mumbai.png"
];

// ignore: camel_case_types
class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
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
                      height: 90,
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
      title: ChartTitle(text: 'Regional Statistics'),
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
            maximumValue: 4000)
      ],
    )));
  }

  List<GraphData> getChartData() {
    final List<GraphData> chartData = [
      GraphData('Closed Issues', Random().nextInt(700)),
      GraphData('Active Issues', Random().nextInt(1400)),
      GraphData('Total Issues Created', Random().nextInt(2100)),
      GraphData('Active NGOs', Random().nextInt(2900)),
      GraphData('Active Users', Random().nextInt(3300)),
    ];
    return chartData;
  }
}

class GraphData {
  GraphData(this.graphFactors, this.graphValue);
  final String graphFactors;
  final int graphValue;
}
