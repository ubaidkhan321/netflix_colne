import 'package:lottie/lottie.dart';
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Screen/authScreen/Signup.dart';
import 'package:netflix_clone/controller/AuthController.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailcontroller = TextEditingController();
    final passwordcontroller = TextEditingController();
    final valkey = GlobalKey<FormState>();
    var controller = Get.put(Authcontroller());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset('assets/netflix.json'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: valkey,
                        child: 
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Email".text.color(Colors.red).make(),
                              TextFormField(
                                controller: emailcontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    "Enter value".text.make();
                                  }
                                  if (!RegExp(
                                          r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$')
                                      .hasMatch(value)) {
                                    return 'Enter correct email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: "Enter Email",
                                    suffixIcon: const Icon(Icons.email),
                                    fillColor: Colors.grey.withOpacity(0.5),
                                    filled: true,
                                    border: const OutlineInputBorder(),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red))),
                              ),
                              "Password".text.color(Colors.red).make(),
                              Obx(
                                () => TextFormField(
                                  controller: passwordcontroller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Password";
                                    }
                                    return null;
                                  },
                                  obscureText: controller.visible.value,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "Enter Password",
                                      suffixIcon: Icon(
                                              controller.visible.value == (true)
                                                  ? Icons.visibility_off
                                                  : Icons.visibility)
                                          .onTap(() {
                                        controller.visible.value =
                                            !controller.visible.value;
                                      }),
                                      fillColor: Colors.grey.withOpacity(0.5),
                                      filled: true,
                                      border: const OutlineInputBorder(),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red))),
                                ),
                              ),
                              10.heightBox,
                              Obx(()=>
                                controller.isloading.value == (true)
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: Colors.red,
                                        strokeWidth: 3,
                                      ))
                                    : "Login Up"
                                        .text
                                        .white
                                        .makeCentered()
                                        .box
                                        .color(Colors.red)
                                        .size(context.screenWidth - 40,
                                            context.screenHeight * 0.07)
                                        .roundedSM
                                        .make()
                                        .onTap(() async {
                                        if (valkey.currentState!.validate()) {
                                          controller.isloading.value = (true);
                                          await controller.userLogin(
                                              emailcontroller.text,
                                              passwordcontroller.text);
                                          controller.isloading.value = (false);
                                        }
                                      }),
                              ),
                              10.heightBox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "Don't have an Account?".text.make(),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(() => const Signup());
                                      },
                                      child: "Sign Up"
                                          .text
                                          .color(Colors.red)
                                          .make()),
                                ],
                              ),
                              10.heightBox,
                              "Login With Google"
                                  .text
                                  .color(Colors.red)
                                  .makeCentered(),
                              10.heightBox,
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      1,
                                      (index) => CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.5),
                                              child: Image.asset(
                                                      "assets/google_logo.png")
                                                  .onTap(() {
                                                controller.signInWithGoogle();
                                              }))
                                          .box
                                          .margin(
                                              const EdgeInsets.only(right: 15))
                                          .make()))
                            ],
                          ),
                      
                      ),
                    )
                  ],
                ).box.white.roundedSM.make(),
              )),
        ),
      ),
    );
  }
}
