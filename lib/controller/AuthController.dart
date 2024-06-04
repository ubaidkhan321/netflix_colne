import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:netflix_clone/Component/firebase_const.dart';
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Screen/HomeNavBar.dart';
import 'package:netflix_clone/Utils/utils.dart';

class Authcontroller extends GetxController {
  var currentindex = 0.obs;
  RxBool checkvalue = false.obs;
  RxBool visible = false.obs;
  RxBool isloading = false.obs;


  changevalue(bool? value) {
    checkvalue.value = value!;
  }

  Future<UserCredential?> userLogin(loginemail, loginpassword) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth
          .signInWithEmailAndPassword(
              email: loginemail, password: loginpassword)
          .then((value) {
        if (auth.currentUser!.emailVerified) {
          Utils().toastMessage("Login SuccessFully");
          Get.to(() => const HomeNavbar());
        } else {
          Utils().toastMessage(
              "Please verify your email by clicking on link sending to you email");
          auth.currentUser!.sendEmailVerification();
        }
        return null;
      });
    } on FirebaseAuthException catch (e) {
      Utils().toastMessage(e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> usersignin(signemail, signpassword) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: signemail, password: signpassword);
    } on FirebaseAuthException catch (e) {
      Utils().toastMessage(e.toString());
    }
    return userCredential;
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  storedata({
    email,
    password,
    name,
  }) {
    DocumentReference store =
        firestore.collection(usercollection).doc(currentuser!.uid);
    store.set({
      'email': email,
      'password': password,
      'name': name,
      'uid': currentuser!.uid,
      'image': '',
    });
  }
}
