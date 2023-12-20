import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/custom_snack_bar.dart';
import '../../../core/utils/helpers/system_helper.dart';
import '../../../data/repositorys/auth_repository.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  late TextEditingController phoneController;

  bool isAccepted = false;

  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

  Future<void> onSignUpPressed() async {
    SystemHelper.closeKeyboard();

    final isValidForm = formKey.currentState!.validate();
    if (isValidForm == false) return;

    if (isAccepted == false) {
      CustomSnackBar.warning(
        title: "Terms & Conditions",
        message: "Please accept the terms & conditions",
      );
      return;
    }

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

  void goToSignInView() => Get.offNamed(Routes.SIGNIN);
}
