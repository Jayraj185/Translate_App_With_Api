import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:translate/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:translate/Screens/HomeScreen/Model/TransalateModel.dart';
import 'package:translate/Utils/ApiHelper/ApiHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: homeController.key,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Translate"),
            centerTitle: true,
            backgroundColor: Colors.redAccent,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: Get.height/15,
                  width: Get.width/1.5,
                  margin: EdgeInsets.only(left: Get.width/30,right: Get.width/30,top: Get.width/15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey,width: 3)
                  ),
                  padding: EdgeInsets.all(Get.width/30),
                  child: Obx(
                      () => DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: homeController.DropdownList.asMap().entries.map((e) => DropdownMenuItem(child: Text("${homeController.DropdownList[e.key]}"),value: "${homeController.DropdownList[e.key]}",onTap: () {
                          homeController.DropdownIndex.value = e.key;
                        },)).toList(),
                        value: homeController.DropdownValue.value,
                        onChanged: (value) {
                          homeController.DropdownValue.value = value!;

                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width/30,right: Get.width/30,top: Get.width/15),
                child: TextFormField(
                  controller: homeController.txtSearch,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey,width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.deepPurple,width: 2)
                    ),
                    hintText: "Type Something....!",
                    prefixIcon: Icon(Icons.edit,color: Colors.deepPurple,),
                    suffixIcon: InkWell(onTap: (){
                      if(homeController.key.currentState!.validate())
                        {
                          homeController.translateText.value = homeController.txtSearch.text;
                        }
                    },child: Icon(Icons.search,color: Colors.deepPurple,)),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) return "Please Type Any words....";
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width/30,top: Get.width/15),
                child: Obx(
                    () => FutureBuilder<TransalateModel?>(
                    future: ApiHelper.apiHelper.GetTranslateText(search: homeController.translateText.value, language: homeController.LanguageCode[homeController.DropdownIndex.value]),
                    builder: (context, snapshot) {
                      if(snapshot.hasError)
                        {
                          return Center(child: Text("${snapshot.error}"),);
                        }
                      else if(snapshot.hasData)
                        {
                          homeController.translateData.value = snapshot.data!.response != null ? snapshot.data!.response! : "Hello Guys\nPleaseType Any Words.....!";
                          return Text(
                            "${homeController.translateData.value}",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15.sp
                            ),
                          );
                        }
                      return Center(child: CircularProgressIndicator(),);
                    },
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Get.defaultDialog(
                title: "Add Language",
                content: Form(
                  key: homeController.Language_key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: homeController.txtLanguageName,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                          hintText: "Enter Your Language Name"
                        ),
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Please Enter Your Language Name";
                          }
                          else if(value.isNotEmpty){
                            for(int i=0; i<homeController.DropdownList.length; i++)
                            {
                              print("===== ${homeController.DropdownList[i]}");
                              if(homeController.DropdownList[i].toString().toLowerCase() == value.toLowerCase())
                              {
                                homeController.txtLanguageName.clear();
                                return "$value Language Already Added\nPlease Enter Correct Language Name";
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(height: Get.width/45,),
                      TextFormField(
                        controller: homeController.txtLanguageCode,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey),),
                          hintText: "Enter Your Language Code"
                        ),
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "Please Enter Your Language Code";
                          }
                          else if(value.isNotEmpty){
                            for(int i=0; i<homeController.LanguageCode.length; i++)
                            {
                              if(homeController.LanguageCode[i].toString().toLowerCase() == value.toLowerCase())
                              {
                                homeController.txtLanguageCode.clear();
                                return "$value Language Code Already Added\nPlease Enter Correct Language Code";
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(height: Get.width/21,),
                      ElevatedButton(
                          onPressed: (){
                            if(homeController.Language_key.currentState!.validate())
                              {
                                homeController.DropdownList.add(homeController.txtLanguageName.text);
                                homeController.LanguageCode.add(homeController.txtLanguageCode.text);
                                Get.back();
                                Get.snackbar("Congratulation", "${homeController.txtLanguageName.text} Language Added Successful");
                                homeController.Language_key.currentState!.reset();
                              }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          child: const Text("Add Language")
                      )
                    ],
                  ),
                )
              );
            },
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
