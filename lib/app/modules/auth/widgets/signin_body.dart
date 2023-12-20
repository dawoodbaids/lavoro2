import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/system_helper.dart';
import '../../../core/utils/validators.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_textformfield.dart';
import '../../../global_widgets/logo_widget.dart';
import '../controllers/signin_controller.dart';

class SigninBody extends GetView<SigninController> {
  const SigninBody({super.key});

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
              LogoWidget(
                height: Get.height * .25,
                width: Get.height * .15,
              ),
              SizedBox(height: Get.height * .10),
              Text(
                "Sign in to your account",
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
              SizedBox(height: Get.height * .05),
              CustomButton(
                label: "Sign in",
                onPressed: controller.onSignInPressed,
              ),
              SizedBox(height: Get.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: controller.goToSignUpView,
                    child: const Text('Sign up'),
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
