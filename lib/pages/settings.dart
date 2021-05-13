import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../providers/language_provider.dart';

class Settings extends StatelessWidget {
  static const routeName = 'settings';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final dataLang = Provider.of<LanguageProvider>(context);

    double responsiveHeight(pixels) {
      return height * (pixels / 725);
    }

    print(dataLang.appLocal);
    return Scaffold(
      body: Container(
        height: height,
        color: Colors.blue,
        child: Column(
          children: [
            Container(
              height: height * 0.12,
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top +
                        (MediaQuery.of(context).size.height * 0.015),
                    left: responsiveHeight(10),
                    right: responsiveHeight(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: responsiveHeight(26),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      AppLocalizations.of(context).translate('settings'),
                      style: TextStyle(
                        fontSize: responsiveHeight(27),
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.transparent,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: height - (height * 0.12),
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsiveHeight(35)),
                    topRight: Radius.circular(responsiveHeight(35)),
                  )),
              child: Padding(
                padding: EdgeInsets.only(top: responsiveHeight(20)),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('language'),
                      style: TextStyle(
                          fontSize: responsiveHeight(22),
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: responsiveHeight(10)),
                    _languageCheckBox(context, 'en', 'English'),
                    _languageCheckBox(context, 'pt', 'Português'),
                    _languageCheckBox(context, 'es', 'Español'),
                    _languageCheckBox(context, 'de', 'Deutsch'),
                    _languageCheckBox(context, 'fr', 'Français'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _languageCheckBox(BuildContext context, String lang, String title) {
  final height = MediaQuery.of(context).size.height;
  final dataLang = Provider.of<LanguageProvider>(context);
  double responsiveHeight(pixels) {
    return height * (pixels / 725);
  }
  return Row(
    children: [
      Checkbox(
        value: AppLocalizations.of(context).translate('locale') == lang
            ? true
            : false,
        onChanged: (value) {
          dataLang.changeLanguage(Locale(lang));
        },
      ),
      Text(
        title,
        style: TextStyle(
            fontSize: responsiveHeight(18), fontWeight: FontWeight.w300),
      ),
    ],
  );
}