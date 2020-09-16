import 'package:path_of_market/models/categoryModels.dart';

class CurrencyItem extends Item{
  @override
  final String itemName;

  final int _count;
  final double _value;
  final double _changePercent;

  CurrencyItem(this.itemName, this._count, this._value, this._changePercent) : super(itemName);

  factory CurrencyItem.fromJson(Map<String, dynamic> json) {
    return CurrencyItem(
      json["currencyTypeName"],
      json["receive"]["count"],
      json["receive"]["value"],
      json["receiveSparkLine"]["totalChange"]
    );
  }
}