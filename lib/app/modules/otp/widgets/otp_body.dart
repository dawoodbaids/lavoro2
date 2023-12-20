import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/system_helper.dart';
import '../../../global_widgets/custom_button.dart';
import '../controllers/otp_controller.dart';

class OtpBody extends GetView<OtpController> {
  const OtpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => SystemHelper.closeKeyboard(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: Get.width,
        height: Get.height,
        child: Form(
          // key: controller.formKey,
          child: ListView(
            children: [
              SizedBox(height: Get.height * .3),
              Text(
                'Code has been send to ${controller.phoneNumber}',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * .05),
              OtpTextField(
                numberOfFields: 6,
                fieldWidth: Get.width * .12,
                borderColor: context.theme.colorScheme.primary,
                focusedBorderColor: context.theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(20.0),
                showFieldAsBox: true,
                filled: true,
                fillColor: context.theme.colorScheme.shadow.withOpacity(.2),
                onSubmit: (String verificationCode) {
                  controller.verificationCode = verificationCode;
                  controller.verify();
                },
              ),
              SizedBox(height: Get.height * .1),
              GetX<OtpController>(
                builder: (_) {
                  final remaining = controller.remaining;
                  if (remaining == '0') {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Oldn\'t receive an OTP?'),
                        TextButton(
                          onPressed: controller.resend,
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Resend code in ',
                        ),
                        TextSpan(
                          text: remaining,
                          style: TextStyle(
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: ' ${controller.unit}',
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: Get.height * .2),
              CustomButton(
                onPressed: controller.verify,
                label: 'Verify',
              )
            ],
          ),
        ),
      ),
    );
  }
}
