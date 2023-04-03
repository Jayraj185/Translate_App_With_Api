import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:translate/Screens/HomeScreen/View/HomePage.dart';

void main()
{
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (p0) => const HomePage(),
        },
      ),
    )
  );
}