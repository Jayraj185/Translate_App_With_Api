import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  TextEditingController txtSearch = TextEditingController();
  TextEditingController txtLanguageCode = TextEditingController();
  TextEditingController txtLanguageName = TextEditingController();

  RxList DropdownList = [
    "Gujarati",
    "English",
    "Hindi",
    "Marathi",
    "Urdu",
    "Spanish",
  ].obs;
  RxList LanguageCode = [
    "gu",
    "en",
    "hi",
    "mr",
    "ur",
    "es"
  ].obs;
  RxString translateText = "Welcome".obs;
  RxString translateData = "".obs;
  RxString DropdownValue = "Gujarati".obs;
  RxInt DropdownIndex = 0.obs;
  RxString SearchData = "".obs;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  GlobalKey<FormState> Language_key = GlobalKey<FormState>();

}