import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/webview_page.dart';
import '../modules/image_picker/bindings/image_picker_binding.dart';
import '../modules/image_picker/views/image_picker_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_detail_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/signup_detail_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/trend/bindings/trend_binding.dart';
import '../modules/trend/views/trend_view.dart';

// import '../modules/latihan/bindings/latihan_binding.dart';
// import '../modules/latihan/views/latihan_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const String INITIAL = _Paths.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGINDETAIL,
      page: () => const LoginDetail(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUPDETAIL,
      page: () => const SignupDetail(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_PICKER,
      page: () => ProductReviewScreen(),
      binding: ImagePickerBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.TREND,
      page: () => const TrendView(),
      binding: TrendBinding(),
    ),
    // GetPage(
    //   name: _Paths.LATIHAN,
    //   page: () => const LatihanView(),
    //   binding: LatihanBinding(),
    // ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),

    GetPage(
      name: _Paths.WEBVIEW_PAGE,
      page: () => WebviewPage(),
      binding: HomeBinding(),
    ),
  ];
}
