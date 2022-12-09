import 'dart:convert';
import 'dart:developer';
import 'package:path_of_market/api/ur_builder.dart';
import 'package:path_of_market/enums/category_type.dart';
import 'package:path_of_market/models/category_models.dart';
import 'package:http/http.dart' as http;

class MainApiService {
  final List<Item> resultList = [];
  final UrlBuilder urlBuilder = UrlBuilder();
  String _url = '';

  http.Response? response;

  Future<List<Item>> getItemList(CategoryType catType) async {

    resultList.clear();

    await _getCategoryItems(catType);

    return resultList;
  }

  Future<void> _getCategoryItems(CategoryType catType) async {
    _url = urlBuilder.buildUrl(catType == CategoryType.currency, catType);

    log("Getting ${catType.name} items by url: $_url");

    response = await http.get(Uri.parse(_url));

    if (response!.statusCode == 200) {
      log('${catType.name} request was successfull.');

      if (catType == CategoryType.currency) {
        resultList.addAll(_decodeCurrencyItems(json.decode(response!.body)));
      } else {
        resultList.addAll(_decodeRegularItems(json.decode(response!.body)));
      }
    } else {
      log('Failed to load ${catType.name} category. ' +
          response!.statusCode.toString() +
          ' ' +
          response!.reasonPhrase!);
    }
  }

  List<Item> _decodeCurrencyItems(Map<String, dynamic> json) {
    var _itemsList = json['lines'] as List;

    return _itemsList.decodeCurrency();
  }

  List<Item> _decodeRegularItems(Map<String, dynamic> json) {
    var _itemsList = json['lines'] as List;

    return _itemsList.decodeRegular();
  }
}
