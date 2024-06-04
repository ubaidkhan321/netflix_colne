import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/Component/firebase_const.dart';
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Screen/HomeNavBar.dart';
import 'package:netflix_clone/Screen/authScreen/Login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   changeScreen(){
   
    Future.delayed( const Duration(seconds: 3),(){
     auth.authStateChanges().listen((User? user) {
      if(user == null && mounted){
         Get.to(()=> const LoginScreen());
      }
      else{
         Get.to(()=> const HomeNavbar());
      }
      
     });
     

    });

  

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("assets/netflix.json"),
    );
  }
}