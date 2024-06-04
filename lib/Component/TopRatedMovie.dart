

import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Constant/firebase_services.dart';
import 'package:netflix_clone/Model/TopRated.dart';

Widget topMoive(final TopRatedMovie? data,){
  return
    
          VxSwiper.builder(
            height: 200,
            aspectRatio: 16/9,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            viewportFraction: 0.8,
            
            itemCount: data!.results.length,
             itemBuilder: (context,snapshot){
              var url = data.results[snapshot].backdropPath;
              return Column(
                children: [
                  Image.network("$imageUrl$url",fit: BoxFit.fill,).box.white.roundedSM.clip(Clip.antiAlias).margin( const EdgeInsets.only(left: 10)).make(),
                   data.results[snapshot].name.text.white.makeCentered()
                ],
              );
          
            }
            
            );
          
       
         
   
}