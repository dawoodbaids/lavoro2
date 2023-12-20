import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:statewatch/app/data/model/user_model.dart';

import '../../../core/utils/helpers/system_helper.dart';
import 'custom_header_widget.dart';
import 'custom_profile_listtile.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = UserAccount.currentUser!;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      children: <Widget>[
        const SizedBox(height: 20),
        const CustomHeaderWidget(),
        CustomProfileListTile(
          label: user.phoneNumber,
          icons: Icons.phone,
          onTap: () => SystemHelper.makeCall(user.phoneNumber),
        ),
        CustomProfileListTile(
          label: user.status,
          icons: Icons.text_fields,
        ),
        SizedBox(height: Get.height * .1),
      ],
    );
  }
}
