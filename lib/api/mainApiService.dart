import 'dart:convert';
import 'dart:developer';
import 'package:path_of_market/api/urlBuilder.dart';
import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/models/categoryModels.dart';
import 'package:http/http.dart' as http;
import 'package:path_of_market/utils/apiConstants.dart';

class MainApiService {
  final List<Category> resultList = [];
  final UrlBuilder urlBuilder = UrlBuilder();
  String _url = '';

  http.Response response;

  Future<List<Category>> getCategoryList() async {
    await _getCurrencyCategory();
    await _getFossilsCategory();
    await _getScarabsCategory();
    await _getDivinationCategory();
    await _getOilsCategory();
    await _getBeastsCategory();
    await _getPropheciesCategory();
    await _getIncubatorsCategory();

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

  Future<void> _getDivinationCategory() async {
    return _getCategory(CategoryType.divinationCards);
  }

  Future<void> _getOilsCategory() async {
    return _getCategory(CategoryType.oils);
  }

  Future<void> _getBeastsCategory() async {
    return _getCategory(CategoryType.beasts);
  }

  Future<void> _getPropheciesCategory() async {
    return _getCategory(CategoryType.prophecies);
  }

  Future<void> _getIncubatorsCategory() async {
    return _getCategory(CategoryType.incubators);
  }

  Future<void> _getCategory(CategoryType catType) async {
    _url = urlBuilder.buildUrl(catType == CategoryType.currency, catType);

    log("Getting ${catType.name} items by url: $_url");

    response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      log('${catType.name} request was successfull.');

      switch (catType) {
        case CategoryType.currency:
          resultList.add(CurrencyCategory.fromJson(
              json.decode(response.body), catType.name));
          break;
        case CategoryType.fossils:
          resultList.add(FossilCategory.fromJson(
              json.decode(response.body), catType.name));
          break;
        case CategoryType.scarabs:
          resultList.add(ScarabCategory.fromJson(
              json.decode(response.body), catType.name));
          break;
        case CategoryType.divinationCards:
          resultList.add(DivinationCardsCategory.fromJson(
              json.decode(response.body), catType.name));
          break;
        case CategoryType.oils:
          resultList.add(
              OilsCategory.fromJson(json.decode(response.body), catType.name));
          break;
        case CategoryType.beasts:
          resultList.add(BeastsCategory.fromJson(
              json.decode(response.body), catType.name));
          break;
        case CategoryType.prophecies:
          resultList.add(PropheciesCategory.fromJson(
              json.decode(response.body), catType.name));
          break;
        case CategoryType.incubators:
          resultList.add(IncubatorsCategory.fromJson(
              json.decode(response.body), catType.name));
          break;
      }
    } else {
      log('Failed to load ${catType.name} category. ' +
          response.statusCode.toString() +
          ' ' +
          response.reasonPhrase);
    }
  }
}
