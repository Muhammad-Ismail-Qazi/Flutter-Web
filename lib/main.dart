import 'dart:js';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.mulishTextTheme().apply(
            bodyColor: Colors.black,
          ),
            pageTransitionsTheme: const PageTransitionsTheme(builders:{
              TargetPlatform.android:FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS:FadeUpwardsPageTransitionsBuilder()
            }),
          primaryColor: Colors.blue
        ),
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}