import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translate/Screens/HomeScreen/Model/TransalateModel.dart';

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();

  Future<TransalateModel?> GetTranslateText({required String search, required String language}) async {
    String apiLink = "https://translate281.p.rapidapi.com/";
    var headers = {
      "content-type" : "application/x-www-form-urlencoded",
      "X-RapidAPI-Key" : "61ac7d9bb5msh9afcaf47b2441eap13b035jsn015f1364291e",
      "X-RapidAPI-Host" : "translate281.p.rapidapi.com",
    };
    var body = "text=$search&from=auto&to=$language";
    var response = await http.post(Uri.parse(apiLink),headers: headers,body: body);

    if(response.statusCode == 200)
      {
        return TransalateModel.fromJson(jsonDecode(response.body));
      }
    else
    {
      return null;
    }
  }
}
