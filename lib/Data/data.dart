import 'package:flutter/material.dart';
import 'package:tes_ciputra/Model/elixirs.dart';
import 'package:tes_ciputra/Model/parentelixirs.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Data {
  static Future<List<parentelixirs>> getData(
      {required BuildContext context, required String url}) async {
    List<parentelixirs> listData = [];
    List<dynamic> listTemp = [];
    try {
      final dio = Dio();
      final response = await dio.get(url);
      var jsondata = response.data;
      final length = jsondata.length;
      for (var i = 0; i < length; i++) {
        print(jsondata[i]);
        listData.add(parentelixirs.fromMap(jsondata[i]));
      }
      var httpurl = Uri.https(
          'wizard-world-api.herokuapp.com', '/wizards', {'': '{https}'});
      var httpresponse = await http.get(httpurl);
      if (httpresponse.statusCode == 200) {
        // for (var i = 0; i < length; i++) {
        //   listData.add(parentelixirs.fromMap(jsondata[i]));
        // }
      } else {
        print('Request failed with status: ${httpresponse.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
    return listData;
  }
}
