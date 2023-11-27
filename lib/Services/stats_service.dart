import 'dart:convert';

import 'package:covid_app/Services/utilities/app_url.dart';
import 'package:http/http.dart'as http;
import 'package:covid_app/Model/world_stats_model.dart';
class StatsServieces{
  Future<WorldStatsModel> fetchWorldStatsRecords()async{
    final response = await http.get(Uri.parse(AppUrl.worldApi));
    if(response.statusCode==200){

      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    }else{
      throw Exception('error');
    }
  }

  Future<List<dynamic>> fetchCountriesStatsRecords()async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesApi));

    if(response.statusCode==200){
      data =jsonDecode(response.body);
      return data;
    }else{
      throw Exception('error');
    }
  }
}