import 'package:covid_app/Services/stats_service.dart';
import 'package:covid_app/View/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class SearchCountriesScreen extends StatefulWidget {
  const SearchCountriesScreen({super.key});

  @override
  State<SearchCountriesScreen> createState() => _SearchCountriesScreenState();
}

class _SearchCountriesScreenState extends State<SearchCountriesScreen> {

  TextEditingController searchcontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServieces statsServieces = StatsServieces();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search a Country'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged:(value){
                setState(
                      (){}
              );
                },
              controller: searchcontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with a Country',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
            ),
          ),
          Expanded(child: FutureBuilder(
              future: statsServieces.fetchCountriesStatsRecords(),
              builder: (context,AsyncSnapshot<List<dynamic>> snapshot){

                if(!snapshot.hasData)
                {
                  return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context,index){
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,

                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                      height: 10 ,
                                      width: 80,
                                      color: Colors.white,
                            ),
                                  subtitle:Container(
                                    height: 10 ,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 10 ,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ));

                      });
                }else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                        String country_name = snapshot.data![index]['country'];
                        if(searchcontroller.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetailScreen(
                                    country_name:snapshot.data![index]['country'],
                                    image:snapshot.data![index]['countryInfo']['flag'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical:snapshot.data![index]['critical'],
                                    active:snapshot.data![index]['active'],
                                    tests:snapshot.data![index]['tests'],
                                    totalCases:snapshot.data![index]['cases'],
                                    totalDeaths:snapshot.data![index]['deaths'],
                                    totalRecovered:snapshot.data![index]['recovered'],
                                  ))
                                  );},
                                child: ListTile(
                                  subtitle:Text(snapshot.data![index]['cases'].toString()) ,
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']
                                    ),),
                                ),
                              )

                            ],
                          );
                        }else if(country_name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryDetailScreen(
                                    country_name:snapshot.data![index]['country'],
                                    image:snapshot.data![index]['countryInfo']['flag'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical:snapshot.data![index]['critical'],
                                    active:snapshot.data![index]['active'],
                                    tests:snapshot.data![index]['tests'],
                                    totalCases:snapshot.data![index]['cases'],
                                    totalDeaths:snapshot.data![index]['deaths'],
                                    totalRecovered:snapshot.data![index]['recovered'],
                                  ))
                                  );},
                                child: ListTile(
                                  subtitle:Text(snapshot.data![index]['cases'].toString()) ,
                                  title: Text(snapshot.data![index]['country']),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']
                                    ),),
                                ),
                              )

                            ],
                          );
                        }else{
                          return Container();
                        }

              });
            }
          })
          )],
      ),

    );
  }
}
