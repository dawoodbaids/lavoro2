import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../global_widgets/loading_widget.dart';
import '../controllers/register_controller.dart';
import '../widgets/register_body.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      isLoading: controller.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RegisterView'),
        ),
        body: const RegisterBody(),
      ),
    );
  }
}
