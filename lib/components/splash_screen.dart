import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/imgs/logo.png",
          width: Get.width * 0.3,
        ),
        SizedBox(
          height: Get.height * 0.05,
        ),
        const Text("폴더형 메모장"),
        SizedBox(
          height: Get.height * 0.05,
        ),
        const Center(child: CircularProgressIndicator())
      ],
    ));
  }
}
