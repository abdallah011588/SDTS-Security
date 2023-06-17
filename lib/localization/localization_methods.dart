import 'package:flutter/material.dart';
import 'package:graduation_project/localization/set_localization.dart';
import 'package:graduation_project/shared/shared_pref.dart';
String? getTranslated(BuildContext context, String key)
{
  return SetLocalization.of(context)!.getTranslateValue(key);
}

String? getLangCode(BuildContext context) {
  return SetLocalization.of(context)!.getCurrentCod();
}
const String ENGLISH = 'en';
const String ARABIC = 'ar';
const String LANG_CODE = 'LANG_CODE';

Future<Locale> setLocale(String languageCode) async {
  await Shared.setData(key: LANG_CODE, value: languageCode);
  return _locale(languageCode);
}

Locale _locale(String langCode) {
  Locale _temp;
  switch (langCode) {
    case ENGLISH:_temp = Locale(langCode, 'US');
      break;
    case ARABIC:_temp = Locale(langCode, 'EG');
      break;
    default:_temp = Locale(ENGLISH, 'US');
      break;
  }
  return _temp;
}
Future<Locale> getLocale() async {
  String languageCode = Shared.getString(key: LANG_CODE)??ENGLISH;
  return _locale(languageCode);
}