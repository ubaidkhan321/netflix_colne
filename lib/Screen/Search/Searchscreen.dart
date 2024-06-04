import 'package:flutter/cupertino.dart';
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Constant/firebase_services.dart';
import 'package:netflix_clone/Model/RecomendationModel.dart';
import 'package:netflix_clone/Model/SearchModel.dart';
import 'package:netflix_clone/Screen/Movie_detailed/Detaile.dart';
import 'package:netflix_clone/Services/MovieServices.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final textcontroller = TextEditingController();
  var controller = Get.find<Movies>();
  SearchMovie? searchfuture;
  late Future<MovieRecommendationsModel> popular;

  void search(String textcontrol) {
    controller.searchMovie(textcontrol).then((result) {
      setState(() {
        searchfuture = result;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    popular = controller.getPopularMovies('movie/popular');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CupertinoSearchTextField(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  controller: textcontroller,
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      search(textcontroller.text);
                    }
                  },
                ),
                10.heightBox,
                textcontroller.text.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Top Movies".text.size(20).bold.make(),
                          FutureBuilder(
                              future: popular,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeAlign: 2,
                                      color: Colors.blue,
                                    ),
                                  );
                                } else {
                                  var data = snapshot.data!.results;
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        final path = snapshot
                                            .data!.results[index].posterPath;
                                        final name =
                                            snapshot.data!.results[index].title;
                                        final overview = snapshot
                                            .data!.results[index].overview
                                            .toString();
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.network(
                                                        "$imageUrl$path")
                                                    .box
                                                    .width(120)
                                                    .white
                                                    .roundedSM
                                                    .clip(Clip.antiAlias)
                                                    .make()
                                                    .onTap(() {
                                                  Get.to((() => MovieDetail(
                                                      id: data[index].id)));
                                                }),
                                                10.widthBox,
                                                Expanded(
                                                    child: Text(
                                                  overview,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                              ],
                                            ),
                                            name.text.bold.make(),
                                          ],
                                        );
                                      });
                                }
                              }),
                        ],
                      )
                    : 
                    
                    
                    
                    FutureBuilder(
                        future: controller.searchMovie(textcontroller.text),
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.data == null) {
                            return "No Data Found".text.makeCentered();
                          } else {
                            return GridView.builder(
                                itemCount: searchfuture!.results.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 200),
                                itemBuilder: (context, index) {
                                  final posterpath =
                                      searchfuture!.results[index].posterPath;
                                  final name =
                                      searchfuture!.results[index].name;
                                  return Column(
                                    children: [
                                      posterpath != null &&
                                              posterpath.isNotEmpty
                                          ? Image.network(
                                              "$imageUrl$posterpath",
                                              fit: BoxFit.cover,
                                              height: 120,
                                            ).onTap(() {
                                              Get.to(MovieDetail(id: searchfuture!.results[index].id));
                                            })
                                          : Container(
                                              height: 120,
                                              color: Colors.grey,
                                              child: const Icon(
                                                Icons.image_not_supported,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                      name.text.make()
                                    ],
                                  );
                                });
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
