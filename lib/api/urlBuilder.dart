import 'package:path_of_market/enums/categoryTypeEnum.dart';
import 'package:path_of_market/utils/apiConstants.dart';

class UrlBuilder {

  static const OR_DELIMETER = "?";
  static const AND_DELIMETER = "&";

  String buildUrl(bool isCurrencyCategory, CategoryType categoryType) {
    String defaultString = MAIN_URL;
    String catType = categoryType.name;

    defaultString += (isCurrencyCategory ? CATEGORY_CURRENCY_PATH : CATEGORY_ITEM_PATH);
    defaultString += OR_DELIMETER;
    defaultString += "league=" + CURRENT_LEAGUE_NAME;
    defaultString += AND_DELIMETER;
    defaultString += "type=" + catType;
    defaultString += "language=" + LANGUAGE_PATH_RU;

    return defaultString;
  }
}