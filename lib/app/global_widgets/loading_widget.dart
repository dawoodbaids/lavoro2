import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  final RxBool isLoading;
  final Widget child;
  const LoadingWidget(
      {super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          return !isLoading.value;
        },
        child: Stack(
          children: [
            child,
            Obx(() {
              if (isLoading.value) {
                return Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.black.withOpacity(.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: context.theme.colorScheme.background,
                          ),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
