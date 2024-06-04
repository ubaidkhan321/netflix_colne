
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Constant/firebase_services.dart';
import 'package:netflix_clone/Model/DetailedModel.dart';
import 'package:netflix_clone/Model/RecomendationModel.dart';
import 'package:netflix_clone/Services/MovieServices.dart';
import 'package:intl/intl.dart';

class MovieDetail extends StatefulWidget {
  final int? id;
  const MovieDetail({super.key, required this.id});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late Future<MovieDetailModel> detailmovie;
   late Future<MovieRecommendationsModel> movieRecommendationModel;
  var controller = Get.find<Movies>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    detailmovie = controller.detailapis(id: widget.id);
    movieRecommendationModel = controller.getMovieRecommendations(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    
   
    
  
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.7),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: detailmovie, 
              builder: (context,snaphot){
                
                if(!snaphot.hasData){
                  return  const Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),);
                }
                else if (snaphot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snaphot.error}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } 
                else{
                  var data = snaphot.data;
            
                 // String genretext = data!.genres.map((genre)=> genre.name).join(',');
                 
                   
                   final   dateformat = DateFormat('dd MMMM yyyy').format(data?.releaseDate  ?? DateTime.now());
                 
                  return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.heightBox,
                  Stack(
                    children: [
                      Image.network(
                      data?.backdropPath == null || data!.backdropPath.isEmpty ?
                      "https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=1459&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                      
                     :
                    
                     
                    
                    
                      "$imageUrl${data.backdropPath}",
                      fit: BoxFit.cover,
                    )
                        .box
                        .height(context.screenHeight * 0.5)
                        .color(Colors.black)
                        .width(double.infinity)
                        .clip(Clip.antiAlias)
                        .roundedSM
                        .make(),
            
                        IconButton(onPressed: (){
                          Get.back();
                        }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,))
                    ],
                  ),
                  10.heightBox,
                  "${data?.title.toString()}".text.white.size(16).makeCentered(),
                  10.heightBox,
                  dateformat.text.white.make(),
                  15.heightBox,
                  "Discription :".text.color(Colors.red).size(18).make(),
                  10.heightBox,
                  "${data?.overview}".text.white.make(),
                  20.heightBox,
                  FutureBuilder(
                    future: movieRecommendationModel,
                     builder: (context,snaphot){
                      if(!snaphot.hasData){
                        return "No data More".text.make();
            
                      }
                      else if(ConnectionState.waiting == ConnectionState){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      else{
                        var data = snaphot.data;
                        return
                         data!.results.isEmpty ?
                          const SizedBox() :
                          Column(
                            children: [
                              "More Movies".text.white.make(),
                               const SizedBox(height: 20),
                                    GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: data.results.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 1.5 / 2,
                                      ),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetail(
                                                        id: data
                                                            .results[index].id),
                                              ),
                                            );
                                          },
                                          child: Image.network("$imageUrl${data.results[index].posterPath}")
                                        );
                                      },
                                    ),
            
            
                            ],
                          );
            
                      }
                     })
            
            
                ],
              ),
              
            );
                }
              }),
          )
          ),
    );
  }
}
