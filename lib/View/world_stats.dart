import 'package:covid_app/Model/world_stats_model.dart';
import 'package:covid_app/Services/stats_service.dart';
import 'package:covid_app/View/search_countries_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});


  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin {

  late final AnimationController _controller =AnimationController(
      duration: Duration(seconds: 3),
      vsync: this
  )..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final ColorsList=<Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];

  @override
  Widget build(BuildContext context) {
    StatsServieces statsServieces=StatsServieces();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          FutureBuilder(
            future: statsServieces.fetchWorldStatsRecords(),
            builder: (context,AsyncSnapshot<WorldStatsModel> snapshot){
            if(!snapshot.hasData){
              return Expanded(child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50,
                controller: _controller,
              ));
            }else{
              return Column(
                children: [
                  PieChart
                    (
                    chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true
                    ),
                  dataMap: {
                    'total': double.parse(snapshot.data!.cases.toString()),
                    'recovered': double.parse(snapshot.data!.recovered.toString()),
                    'deaths':double.parse(snapshot.data!.deaths.toString())
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                    child: Card(
                      child:Column(
                        children: [
                          ReuseableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                          ReuseableRow(title: 'Recovered People', value: snapshot.data!.recovered.toString()),
                          ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                          ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                          ReuseableRow(title: 'Critical' , value: snapshot.data!.critical.toString()),
                          ReuseableRow(title: 'Today Death', value: snapshot.data!.todayDeaths.toString()),
                          ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCountriesScreen()));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff1aa260),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text('track countries'),
                        ),
                      ),
                    ),
                  )],
              );
            }
          },
          ),
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title,value;
  ReuseableRow({super.key,required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 10,),
          Divider(
            color: Colors.grey,
            height: 3,
            thickness: 0,
          )
        ],
      ),
    );
  }
}
