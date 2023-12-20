import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/custom_snack_bar.dart';
import '../../../core/utils/helpers/system_helper.dart';
import '../../../data/repositorys/auth_repository.dart';
import '../../../routes/app_pages.dart';

class SigninController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  late TextEditingController phoneController;
  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

  Future<void> onSignInPressed() async {
    SystemHelper.closeKeyboard();

    final isValidForm = formKey.currentState!.validate();
    if (isValidForm == false) return;

    isLoading(true);

    try {
      await AuthRepository.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationFailed: (error) {
          isLoading(false);
          CustomSnackBar.error(message: error.message.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          isLoading(false);
          Get.toNamed(Routes.OTP, arguments: {
            'phoneNumber': phoneController.text,
            'verificationId': verificationId
          });
        },
      );

      // AuthController.goToHomeView();
    } on FirebaseAuthException catch (error) {
      String errorMessage;
      switch (error.code) {
        case 'user-not-found':
          errorMessage = "User not found";
          break;
        case 'user-disabled':
          errorMessage = "User disabled";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email";
          break;
        case 'wrong-password':
          errorMessage = "The password is wrong";
          break;
        default:
          errorMessage = "Error";
      }

      isLoading(false);
      CustomSnackBar.error(message: errorMessage);
    }
  }

  void comingSoon() {
    CustomSnackBar.defaultSnackBar(
      title: "Coming Soon",
      message: "This feature will be added soon..",
    );
  }

  void goToSignUpView() => Get.offNamed(Routes.SIGNUP);
}
