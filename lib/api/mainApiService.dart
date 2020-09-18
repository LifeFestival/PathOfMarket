import 'dart:convert';
import 'dart:developer';

import 'package:path_of_market/models/categoryModels.dart';
import 'package:http/http.dart' as http;

class MainApiService {
  final List<Category> resultList = [];

  http.Response response;

  Future<List<Category>> getCategoryList() async {
    return _getCurrencyCategory();
  }

  Future<List<Category>> _getCurrencyCategory() async {
    response = await http.get(
        'https://poe.ninja/api/data/currencyoverview?league=heist&type=Currency&language=ru');

    if (response.statusCode == 200) {
      log('Currency request was sucsessfull.');
      resultList.add(CurrencyCategory.fromJson(
          json.decode(response.body), 'Currency category'));

      return resultList;
    } else {
      log('Failed to load currency category.' +
          response.statusCode.toString() +
          response.reasonPhrase);

      return resultList;
    }
  }
}
