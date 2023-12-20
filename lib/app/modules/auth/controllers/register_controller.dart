import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/custom_snack_bar.dart';
import '../../../core/utils/helpers/system_helper.dart';
import '../../../data/model/user_model.dart';
import '../../../data/provider/firebase_image.dart';
import '../../../data/provider/user_firebase.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  late User? user;

  late TextEditingController usernameController;
  late TextEditingController statusController;
  late TextEditingController jobController;
  late TextEditingController emailController;
  String? imagePath;

  @override
  void onInit() {
    usernameController = TextEditingController();
    statusController = TextEditingController();
    jobController = TextEditingController();
    emailController = TextEditingController();
    user = Get.arguments['user'];

    super.onInit();
  }

  Future<void> onContinuePressed() async {
    SystemHelper.closeKeyboard();
    final isValidForm = formKey.currentState!.validate();
    if (isValidForm == false) return;
    if (imagePath == null || imagePath!.isEmpty) {
      CustomSnackBar.warning(
        title: "Profile picture",
        message: "Please select a profile picture",
      );
      return;
    }

    isLoading(true);

    try {
      final uuid = user!.uid;
      final imageUrl = await FirebaseImage.uploadUserImage(
        imagePath: imagePath!,
        uid: uuid,
      );

      UserAccount userAccount = UserAccount(
        uid: uuid,
        username: usernameController.text,
        imageUrl: imageUrl!,
        status: statusController.text,
        phoneNumber: user!.phoneNumber ?? '',
        jobDescrption: jobController.text,
        email: emailController.text,
      );

      await UserFirebase.setUser(userAccount: userAccount);

      UserAccount.currentUser = userAccount;

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      CustomSnackBar.error(message: e.toString());
    }

    isLoading(false);
  }
}
