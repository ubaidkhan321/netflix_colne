import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Screen/Home/Home.dart';
import 'package:netflix_clone/Screen/New&Hot/NewMovie.dart';
import 'package:netflix_clone/Screen/Search/Searchscreen.dart';
import 'package:netflix_clone/controller/AuthController.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    var navbarlist = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
      const BottomNavigationBarItem(
          icon: Icon(Icons.photo_library_outlined), label: "New"),
    ];
    var navbodylist = [
      const HomeScreen(),
      const SearchScreen(),
      const NewMovies(),
    ];
    var controller = Get.put(Authcontroller());
    return Scaffold(
      body: Column(children: [
        Obx(() => Expanded(
            child: navbodylist.elementAt(controller.currentindex.value)))
      ]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (value) {
              controller.currentindex.value = value;
            },
            currentIndex: controller.currentindex.value,
            selectedItemColor: Colors.red,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: navbarlist),
      ),
    );
  }
}
