

import 'package:netflix_clone/Component/TopRatedMovie.dart';
import 'package:netflix_clone/Component/update_Movie.dart';
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Model/TopRated.dart';
import 'package:netflix_clone/Model/UpworkMovie.dart';
import 'package:netflix_clone/Screen/Search/Searchscreen.dart';
import 'package:netflix_clone/Services/MovieServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {
    late Future<UpcomingModel> upcomingfuture;
    late Future<UpcomingModel> nowplayingfuture;
    late Future<TopRatedMovie> topseries;
      var services = Get.put(Movies());
     
    @override
void initState() {
  super.initState();
  topseries =  services.fetchData<TopRatedMovie>(
    "tv/top_rated",
    (json) => TopRatedMovie.fromJson(json)
  );
  nowplayingfuture = services.fetchData<UpcomingModel>(
    "movie/now_playing",
    (json) => UpcomingModel.fromJson(json),
  );
  upcomingfuture = services.fetchData<UpcomingModel>(
    "movie/upcoming",
    (json) => UpcomingModel.fromJson(json),
  );
}


  @override
  Widget build(BuildContext context) {
    
     

    return Scaffold(
      
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
               25.heightBox,
              Row(
                children: [
                 
                  "NETFLIX".text.color(Colors.red).fontWeight(FontWeight.bold).size(25).make(),
                   const Spacer(),
                  const Icon(Icons.search,color: Colors.white,size: 25,).onTap(() {
                    Get.to(()=> const SearchScreen());
                  }),
                  15.widthBox,
                  const Icon(Icons.menu,color: Colors.white,size: 25,),
                ],
              ),
                    10.heightBox,
                    FutureBuilder(
                      future: topseries,
                     builder: (context,snapshot){
                      if(!snapshot.hasData){
                        
                         return const Center(child: CircularProgressIndicator(strokeAlign: 2,color: Colors.blue,),);

                      }
                      else{
                        return
                      
                          
                                topMoive(snapshot.data);
                                
                              
                            
                            

                          
                        
                      }
                      
                     
                     }),
                     
            
                     10.heightBox,
                    comingMovie(upcomingfuture, "UpComing Movie"),
                    10.heightBox,
                    comingMovie(nowplayingfuture, "Now Playing")

          
             
            ],
          
            
          ),
        ),
        
      ),
    );
  }
}