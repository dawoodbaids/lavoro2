import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/system_helper.dart';
import '../../../core/utils/validators.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_check_box.dart';
import '../../../global_widgets/custom_textformfield.dart';
import '../../../global_widgets/logo_widget.dart';
import '../controllers/signup_controller.dart';

class SignupBody extends GetView<SignupController> {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => SystemHelper.closeKeyboard(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: Get.width,
        height: Get.height,
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              SizedBox(height: Get.height * .05),
              LogoWidget(
                height: Get.height * .15,
                width: Get.height * .15,
              ),
              SizedBox(height: Get.height * .22),
              Text(
                "Sign up to your account",
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall,
              ),
              SizedBox(height: Get.height * .05),
              CustomTextFormField(
                controller: controller.phoneController,
                prefixIcon: const Icon(Icons.phone),
                label: "Phone Number",
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumber],
                validator: CustomValidator.validatePhoneNumber,
                required: true,
              ),
              SizedBox(height: Get.height * .015),
              CustomCheckBox(
                text: 'I accept all terms and conditions',
                initialValue: controller.isAccepted,
                onChanged: (isChecked) {
                  controller.isAccepted = isChecked;
                },
              ),
              SizedBox(height: Get.height * .015),
              CustomButton(
                label: "Sign up",
                onPressed: controller.onSignUpPressed,
              ),
              SizedBox(height: Get.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do you have an account?'),
                  TextButton(
                    onPressed: controller.goToSignInView,
                    child: const Text('Sign in'),
                  )
                ],
              ),
              SizedBox(height: Get.height * .1),
            ],
          ),  
        ),
      ),
    );
  }
}
