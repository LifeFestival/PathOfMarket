import 'dart:convert';
import 'dart:developer';
import 'package:path_of_market/api/urlBuilder.dart';
import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:http/http.dart' as http;

class MainApiService {
  final List<Category> resultList = [];
  final UrlBuilder urlBuilder = UrlBuilder();

  http.Response response;

  Future<List<Category>> getCategoryList() async {
    await _getCurrencyCategory();
    await _getFossilsCategory();

    return resultList;
  }

  Future<List<Category>> _getCurrencyCategory() async {
    String url = urlBuilder.buildUrl(true, CategoryType.currency);

    response = await http.get(url);

    if (response.statusCode == 200) {
      log('Currency request was sucsessfull.');
      resultList.add(CurrencyCategory.fromJson(
          json.decode(response.body), CategoryType.currency.name));

      return resultList;
    } else {
      log('Failed to load currency category.' +
          response.statusCode.toString() +
          response.reasonPhrase);

      return resultList;
    }
  }

  Future<List<Category>> _getFossilsCategory() async {
    String url = urlBuilder.buildUrl(false, CategoryType.fossils);

    response = await http.get(url);

    if (response.statusCode == 200) {
      log('Fossils request was successfull.');
      resultList.add(FossilCategory.fromJson(
          json.decode(response.body), CategoryType.fossils.name));

      return resultList;
    } else {
      log('Failed to load fossils category.' +
          response.statusCode.toString() +
          response.reasonPhrase);
    }

    return resultList;
  }
}
