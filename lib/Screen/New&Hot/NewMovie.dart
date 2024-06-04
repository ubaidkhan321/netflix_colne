
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Screen/New&Hot/hots&coming.dart';

class NewMovies extends StatefulWidget {
  const NewMovies({super.key});

  @override
  State<NewMovies> createState() => _NewMoviesState();
}

class _NewMoviesState extends State<NewMovies> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: SafeArea(
        child: Scaffold(
          
          backgroundColor: Colors.black,
          body: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              Row(
                children: [
                  19.widthBox,
                  
                  "Hot & New".text.white.make(),
                   const Spacer(),
                    const Icon(Icons.cast,color: Colors.white,),
                    10.widthBox,
                   
                   
      
      
                ],
              ),
              10.heightBox,
              TabBar(
                indicatorColor: Colors.red,
                dividerColor: Colors.black,
              
                tabs: [
                Tab(
                  child: "Coming Soon".text.white.make(),
                ),
                Tab(
                  child: "Everyone Watching".text.white.make(), 
                )
              ]),
              Expanded(
                child: TabBarView(children: 
                [
                const  ComingSoonMovieWidget(
                    imageUrl:
                        'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                    overview:
                        'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                    logoUrl:
                        "https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg",
                    month: "Jun",
                    day: "19",
                  ),
                
                  Container(
                    color: Colors.blue
                    ,
                    height: 200,
                    width: 200,
                  )
                ]),
              )
              
           
              
            ],
          ),
        ),
      ),
    );
  }
}