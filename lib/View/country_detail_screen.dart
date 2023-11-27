import 'package:covid_app/Services/stats_service.dart';
import 'package:covid_app/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CountryDetailScreen extends StatefulWidget {
  String country_name;
  String image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,tests;
  CountryDetailScreen(
      {
        required this.country_name,
        required this.image,
        required this.todayRecovered,
        required this.critical,
        required this.active,
        required this.tests,
        required this.totalCases,
        required this.totalDeaths,
        required this.totalRecovered,
      }
      );

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  StatsServieces statsServieces=StatsServieces();
  @override
  final ColorsList=<Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xff9a46de),
    Color(0xffffce00),
    Color(0xffff7c00),
    Color(0xff042059),
    Color(0xff9d0000),

  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Row(
            children: [
            Image(
                height: 30,
                image: NetworkImage(
                    widget.image)
            ),
            SizedBox(width: 10,),
            Text(widget.country_name),
            ],
          )
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PieChart(chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
            dataMap: {
              'Total Cases': double.parse(widget.totalCases.toString()),
              'Total Deaths': double.parse(widget.totalDeaths.toString()),
              'Total Recovered': double.parse(widget.totalRecovered.toString()),
              'Critical Condition': double.parse(widget.critical.toString()),
              'Active Cases': double.parse(widget.active.toString()),
              'Recovered Today': double.parse(widget.todayRecovered.toString()),
              'Tests': double.parse(widget.tests.toString()),


            },
            legendOptions: LegendOptions(
              showLegends: true,
              legendPosition: LegendPosition.left,
            ),
            chartRadius: MediaQuery.of(context).size.width/3.2,
            animationDuration: Duration(milliseconds: 1200),
            chartType: ChartType.ring,
            colorList: ColorsList,

          ),




        SizedBox(height: 30,),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Card(
              child: Column(
                children: [
                  ReuseableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                  ReuseableRow(title: 'totalDeaths,', value: widget.totalDeaths.toString()),
                  ReuseableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                  ReuseableRow(title: 'Critical Condition', value: widget.critical.toString()),
                  ReuseableRow(title: 'Active Cases', value: widget.active.toString()),
                  ReuseableRow(title: 'Recovered Today', value: widget.todayRecovered.toString()),
                  ReuseableRow(title: 'Tests', value: widget.tests.toString()),


                ],
              ),
            )
          ],
        )
      ],
    ),
    );
  }
}
