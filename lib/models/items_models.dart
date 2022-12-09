import 'dart:convert';
import 'dart:ffi';

import 'package:path_of_market/models/category_models.dart';

class CurrencyItem extends Item {
  @override
  final String itemName;

  CurrencyItem(this.itemName, int count, double value, num changePercent)
      : super(itemName, count, value, changePercent.toDouble());

  factory CurrencyItem.fromJson(Map<String, dynamic> json) {
    return CurrencyItem(
        json["currencyTypeName"],
        json["receive"]["count"],
        json["receive"]["value"],
        json["receiveSparkLine"]["totalChange"]);
  }
}

class RegularItem extends Item {
  @override
  final String itemName;

  RegularItem(this.itemName, int count, double value, num changePercent)
      : super(itemName, count, value, changePercent.toDouble());

  factory RegularItem.fromJson(Map<String, dynamic> json) {
    return RegularItem(json["name"], json["count"], json["chaosValue"],
        json["sparkline"]["totalChange"]);
  }
}
