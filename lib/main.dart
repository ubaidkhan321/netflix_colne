
import 'package:firebase_core/firebase_core.dart';
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Screen/Splash_Services/SplashScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Flutter Demo',
      theme: ThemeData(
       
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(fontSize: 24,color: Colors.white),
        //   bodySmall: TextStyle(fontSize: 18,color: Colors.white),
          
        // ),
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}

