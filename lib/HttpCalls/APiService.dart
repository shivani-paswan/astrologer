import 'dart:convert';

import 'package:astrologer/HomeScreen/Models/AstrologerListModel.dart';
import 'package:astrologer/HttpCalls/ApicConstants.dart';
import 'package:astrologer/HttpCalls/ResponseModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ResponseModel> getDataList(
      String apiName, Map<String, String> params) async {
    String apiWithParams = '$apiName?';

    try {
      for (final entries in params.entries) {
        final key = entries.key;
        final value = entries.value;
        apiWithParams += '$key=$value&';
      }
      apiWithParams = apiWithParams.substring(0, apiWithParams.length - 1);
      var url = Uri.parse(ApiConstants.baseUrl + apiWithParams);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonObj = ResponseModel.fromJson(jsonDecode(response.body));
        return jsonObj;
      } else {
        throw Exception('Failed to Get Data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
