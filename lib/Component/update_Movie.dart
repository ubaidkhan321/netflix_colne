
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Constant/firebase_services.dart';
import 'package:netflix_clone/Model/UpworkMovie.dart';
import 'package:netflix_clone/Screen/Movie_detailed/Detaile.dart';


Widget comingMovie(Future<UpcomingModel> future,String? title){
  return FutureBuilder(
      future: future, 
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return
         const Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.black,),);
        }
        else{
          var data = snapshot.data?.results;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title".text.fontWeight(FontWeight.bold).white.make(),
            10.heightBox,
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (context,index){
                return Image.network("$imageUrl${data[index].posterPath}").onTap(() {
                  Get.to(()=> MovieDetail(id: data[index].id ));
                });
              }),
            )
          ],
        ).box.height(220).make();

        }
        
      });

}