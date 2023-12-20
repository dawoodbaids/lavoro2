import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'HomeView is working',
      style: TextStyle(
        fontSize: 20,
      ),
    ));
  }
}
