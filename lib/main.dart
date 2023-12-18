import 'package:flutter/material.dart';
import 'package:fihirana/app/utils/AppTheme.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Fihirana",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppThemes.primary),
        primaryColor: AppThemes.primary,
        useMaterial3: true,
      ),
    ),
  );
}
