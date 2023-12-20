import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/custom_snack_bar.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repositorys/auth_repository.dart';
import '../../../routes/app_pages.dart';

class OtpController extends GetxController {
  late Timer _timer;
  final RxInt _secondsRemaining = 119.obs; // 2 minutes in seconds

  RxBool isLoading = false.obs;
  String verificationCode = '';

  late String phoneNumber;
  late String verificationId;

  String get minutes => (_secondsRemaining / 60).floor().toString();
  String get seconds => (_secondsRemaining % 60).toString().padLeft(1, '0');

  String get remaining =>
      _secondsRemaining < 60 ? seconds : '$minutes:$seconds';

  String get unit => _secondsRemaining < 60 ? 's' : 'm';

  @override
  void onInit() {
    super.onInit();

    final data = Get.arguments as Map<String, dynamic>;
    phoneNumber = data['phoneNumber'];
    verificationId = data['verificationId'];
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_secondsRemaining.value < 1) {
          timer.cancel();
          // Handle timer completion here, like enabling the resend button.
        } else {
          _secondsRemaining.value -= 1;
        }
      },
    );
  }

  Future<void> verify() async {
    isLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );

      final user =
          await AuthRepository.signInWithCredential(credential: credential);

      if (user.additionalUserInfo!.isNewUser == true) {
        Get.toNamed(Routes.REGISTER, arguments: {'user': user.user});
      } else {
        await UserAccount.init();
        Get.offAllNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-verification-code':
          CustomSnackBar.error(message: 'Invalid verification code');
          break;
        default:
          CustomSnackBar.error(message: e.message ?? 'Error');
      }
    }
    isLoading(false);
  }

  Future<void> resend() async {
    isLoading(true);

    try {
      await AuthRepository.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationFailed: (error) {
          isLoading(false);
          CustomSnackBar.error(message: error.message.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          isLoading(false);
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      CustomSnackBar.error(message: e.message ?? 'Error');
    }
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }
}
