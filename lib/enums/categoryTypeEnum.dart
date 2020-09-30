import 'package:path_of_market/utils/categoryNames.dart';

enum CategoryType {
  currency,
  scarabs,
  divinationCards,
  oils,
  fossils,
  beasts,
  prophecies,
  incubators
}

extension CategoryName on CategoryType {

  static const names = {
    CategoryType.currency: CURRENCY_CAT_NAME,
    CategoryType.beasts: BEASTS_CAT_NAME,
    CategoryType.divinationCards: DIV_CARD_CAT_NAME,
    CategoryType.prophecies: PROPHECIES_CAT_NAME,
    CategoryType.scarabs: SCARABS_CAT_NAME,
    CategoryType.fossils: FOSSILS_CAT_NAME,
    CategoryType.incubators: INCUBATOR_CAT_NAME,
    CategoryType.oils: OILS_CAT_NAME
  };

  String get name => names[this];
}

String _test() {
  CategoryType cat = CategoryType.beasts;

  return cat.name;
}