// ignore_for_file: unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:statewatch/app/routes/app_pages.dart';

import '../data/model/user_model.dart';
import '../data/repositorys/auth_repository.dart';
import 'custom_button.dart';
import 'user_image_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * .7,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            // decoration: const BoxDecoration(color: Colors.orange),
            currentAccountPicture: UserImageWidget(
              size: Get.height * .08,
              margin: EdgeInsets.zero,
              onTap: () => Get.toNamed(Routes.USER_PROFILE),
            ),
            accountName: Text(
              UserAccount.currentUser?.username.capitalize ?? "User Name",
              style: TextStyle(
                color: Get.theme.colorScheme.background,
              ),
            ),
            accountEmail: Text(
              UserAccount.currentUser?.phoneNumber ?? "+9627xxxxxxxx",
              style: TextStyle(
                color: Get.theme.colorScheme.background,
              ),
            ),
            otherAccountsPictures: [
              IconButton(
                onPressed: () async {
                  await Get.defaultDialog(
                    title: "SignOut",
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 25),
                        Text(
                          "You're leaving\nAre you sure?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                    confirm: CustomButton(
                      backgroundColor: Colors.transparent,
                      label: "Yes, Log Me Out",
                      onPressed: () => AuthRepository.signOut(),
                    ),
                    cancel: CustomButton(
                      label: "Cancel",
                      onPressed: () => Get.back(),
                    ),
                  );
                },
                tooltip: "SignOut",
                icon: const Icon(FontAwesomeIcons.rightFromBracket),
                color: Get.theme.colorScheme.background,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final IconData icons;
  final String? viewNamed;
  final bool enabled;
  final Function()? onTap;
  final Color? iconColor;
  const _DrawerItem({
    required this.title,
    required this.icons,
    this.enabled = true,
    this.subTitle,
    this.viewNamed,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: enabled ? "" : "Coming soon",
      child: ListTile(
        leading: Icon(
          icons,
          color: iconColor,
        ),
        enabled: enabled,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        subtitle: subTitle != null ? Text(subTitle!) : null,
        onTap: onTap ??
            () {
              Get.back();
              if (viewNamed != null) {
                Get.toNamed(viewNamed!);
              }
            },
      ),
    );
  }
}
