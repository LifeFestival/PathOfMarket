import 'dart:convert';
import 'dart:developer';
import 'package:path_of_market/api/urlBuilder.dart';
import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:http/http.dart' as http;

class MainApiService {
  final List<Category> resultList = [];
  final UrlBuilder urlBuilder = UrlBuilder();
  String _url = '';

  http.Response response;

  Future<List<Category>> getCategoryList() async {
    await _getCurrencyCategory();
    await _getFossilsCategory();
    await _getScarabsCategory();

    return resultList;
  }

  Future<void> _getCurrencyCategory() async {
    return _getCategory(CategoryType.currency);
  }

  Future<void> _getFossilsCategory() async {
    return _getCategory(CategoryType.fossils);
  }

  Future<void> _getScarabsCategory() async {
    return _getCategory(CategoryType.scarabs);
  }

  Future<void> _getCategory(CategoryType catType) async {
    _url = urlBuilder.buildUrl(catType == CategoryType.currency, catType);

    log("Getting ${catType.name} items by url: $_url");
    response = await http.get(_url);

    if (response.statusCode == 200) {

      log('${catType.name} request was successfull.');

      switch (catType) {
        case CategoryType.currency : resultList.add(CurrencyCategory.fromJson(json.decode(response.body), catType.name));         
          break;
        case CategoryType.fossils : resultList.add(FossilCategory.fromJson(json.decode(response.body), catType.name));
          break;
        case CategoryType.scarabs : resultList.add(ScarabCategory.fromJson(json.decode(response.body), catType.name));
          break;
        case CategoryType.divinationCards:
          // TODO: Handle this case.
          break;
        case CategoryType.oils:
          // TODO: Handle this case.
          break;
        case CategoryType.beasts:
          // TODO: Handle this case.
          break;
        case CategoryType.prophecies:
          // TODO: Handle this case.
          break;
        case CategoryType.incubators:
          // TODO: Handle this case.
          break;
      }

    } else {
      log('Failed to load ${catType.name} category. ' +
          response.statusCode.toString() + ' ' +
          response.reasonPhrase);
    }

  }
}
