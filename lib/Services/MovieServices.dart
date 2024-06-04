 
 import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Constant/firebase_services.dart';

import 'package:http/http.dart' as http;
import 'package:netflix_clone/Model/DetailedModel.dart';
import 'package:netflix_clone/Model/RecomendationModel.dart';
import 'package:netflix_clone/Model/SearchModel.dart';
import 'package:netflix_clone/Utils/utils.dart';


const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endpoint;

class Movies extends GetxController{

  Future<SearchMovie> searchMovie(String textcontroller)async{
  


     endpoint = "search/tv?query=$textcontroller";
     final url = "$baseUrl$endpoint";
     final respone = await http.get(Uri.parse(url),headers: {
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc"

     });
     var body = jsonDecode(respone.body.toString());
     if(respone.statusCode == 200){
      print("Successfull$url");
      
      return SearchMovie.fromJson(body);
      

     }
     throw Exception("Failed to load");

    
  }

   Future<T> fetchData<T>(String endpoint, T Function(Map<String, dynamic>) modelFromJson) async {
  final url = "$baseUrl$endpoint$key";

  try {
    final response = await http.get(
      Uri.parse(url),);
  

    if (response.statusCode == 200) {
      if(kDebugMode){
          print("Successful: ${response.body}");

      }
    
      return modelFromJson(jsonDecode(response.body));
    } else {
      if(kDebugMode){
        print("Failed with status: ${response.statusCode}");

      }
      
      throw Exception("Failed to load");
    }
  } catch (e) {
    if(kDebugMode){
      print("Error occurred: $e");

    }
    
    throw Exception("Failed to load");
  }
}
 Future<MovieRecommendationsModel> getPopularMovies(String endpoint) async {
    endpoint =  endpoint;
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      print("Success");
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now playing movies');
  }




Future<MovieDetailModel> detailapis({int? id}) async{

  try{
     endpoint = "movie/$id";
  final url = "$baseUrl$endpoint";
  final respone = await http.get(Uri.parse(url),headers: {

    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc"


  });
  var body = jsonDecode(respone.body.toString());

  if(respone.statusCode == 200){
    if(kDebugMode){
        print("Success with status: ${respone.body}");

      }
     return MovieDetailModel.fromJson(body);
  }
  else{

     if(kDebugMode){
        print("Failed with status: ${respone.statusCode}");

      }
      throw Exception("Failed to load");
  }

  
   
 
}catch (e){
    Utils().toastMessage(e.toString());
    throw Exception("Failed to data sent $e");

    

  }
 


}

Future<MovieRecommendationsModel> getMovieRecommendations(int movieId) async {
    endpoint = 'movie/$movieId/recommendations';
    final url = '$baseUrl$endpoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      if(kDebugMode){
         print('success');

      }
     
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }




 

}