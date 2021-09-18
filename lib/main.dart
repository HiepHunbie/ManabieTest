import 'package:demo/utils/localization_service.dart';
import 'package:demo/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ScreenUtilInit(
        builder: () => GetMaterialApp(
          title: 'GetX App',
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeft,
          locale: LocalizationService.locale,
          fallbackLocale: LocalizationService.fallbackLocale,
          translations: LocalizationService(),
          getPages: Routers.route,
          initialRoute: '/homeView',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
              color: Colors.deepOrange,
              textTheme: TextTheme(
                headline6: GoogleFonts.exo2(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  });

}
