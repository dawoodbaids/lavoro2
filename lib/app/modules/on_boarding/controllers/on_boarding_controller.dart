import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../../core/theme/app_theme.dart';
import '../widgets/on_boarding_page.dart';

class OnBoardingController extends GetxController {
  late final LiquidController liquidController;

  RxInt currentPage = 0.obs;
  final RxBool _isLastPage = false.obs;

  bool get isListPage => _isLastPage.value;

  @override
  void onInit() {
    super.onInit();
    liquidController = LiquidController();

    _isLastPage(pages.length == 1);
  }

  final pages = [
    OnBoardingPage(
      description:
          'Welcome to StateWatch! Get real-time government news and legislative updates at your fingertips. Stay informed, empowered, and engaged with our user-friendly app.',
      data: Get.isDarkMode ? AppTheme.dark : AppTheme.light,
    ),
    OnBoardingPage(
      description:
          'Stay up-to-date with the latest government news and policy updates from local to national levels. StateWatch keeps you informed in real-time.',
      data: Get.isDarkMode ? AppTheme.light : AppTheme.dark,
    ),
    OnBoardingPage(
      description:
          'Personalize your news feed with topics that matter to you. Receive customized alerts on government initiatives and policy changes tailored to your interests.',
      data: Get.isDarkMode ? AppTheme.dark : AppTheme.light,
    ),
  ];

  onPageChangeCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
    _isLastPage(activePageIndex == pages.length - 1);
  }

  skip() => liquidController.jumpToPage(page: pages.length - 1);

  animateToNextSlide() {
    int nextPage = liquidController.currentPage + 1;
    liquidController.animateToPage(page: nextPage, duration: 300);
  }
}
