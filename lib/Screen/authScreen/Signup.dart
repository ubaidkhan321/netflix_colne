import 'package:lottie/lottie.dart';
import 'package:netflix_clone/Constant/const.dart';
import 'package:netflix_clone/Utils/utils.dart';
import 'package:netflix_clone/controller/AuthController.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Authcontroller>();
    final namecontroller = TextEditingController();
    final emailcontroller = TextEditingController();
    final passcontroller = TextEditingController();
    final golkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: "SignUp".text.makeCentered(),
      ),
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
                    10.heightBox,
                    LottieBuilder.asset('assets/signin1.json', width: 200),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: golkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Name".text.color(Colors.red).make(),
                            TextFormField(
                              controller: namecontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Name";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "Enter Name",
                                  suffixIcon: const Icon(Icons.person),
                                  fillColor: Colors.grey.withOpacity(0.5),
                                  filled: true,
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                            "Email".text.color(Colors.red).make(),
                            TextFormField(
                              controller: emailcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter email";
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
                                controller: passcontroller,
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
                            Obx(
                              () => Row(
                                children: [
                                  Checkbox(
                                      fillColor: const MaterialStatePropertyAll(
                                          Colors.red),
                                      value: controller.checkvalue.value,
                                      onChanged: (value1) {
                                        controller.changevalue(value1);
                                      }),
                                  10.widthBox,
                                  RichText(
                                      text: const TextSpan(children: [
                                    TextSpan(
                                        text: 'I agree to this',
                                        style: TextStyle(color: Colors.grey)),
                                    TextSpan(
                                        text: " term & condition",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(
                                        text: " &",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(
                                        text: " Privicy",
                                        style: TextStyle(color: Colors.grey))
                                  ])),
                                ],
                              ),
                            ),
                            10.heightBox,
                            Obx(
                              () => controller.isloading.value == (true)
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.red,
                                      strokeWidth: 2,
                                    ))
                                  : "Sign Up"
                                      .text
                                      .white
                                      .makeCentered()
                                      .box
                                      .color(
                                          controller.checkvalue.value == (true)
                                              ? Colors.red
                                              : Colors.white)
                                      .size(context.screenWidth - 40,
                                          context.screenHeight * 0.07)
                                      .roundedSM
                                      .make()
                                      .onTap(() async {
                                      if (golkey.currentState!.validate()) {
                                        try {
                                          controller.isloading.value = (true);
                                          await controller.usersignin(
                                              emailcontroller.text,
                                              passcontroller.text);
                                          await controller.storedata(
                                              email: emailcontroller.text,
                                              password: passcontroller.text,
                                              name: namecontroller.text);

                                              controller.isloading.value = (false);

                                          Utils().toastMessage(
                                              "SignUp Successfully");
                                          Get.back();
                                        } catch (e) {
                                          Utils().toastMessage(e.toString());
                                        }
                                      }
                                    }),
                            )
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
