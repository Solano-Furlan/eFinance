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
                    top: responsiveHeight(30),
                    left: responsiveHeight(15),
                    right: responsiveHeight(15)),
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
                    Row(
                      children: [
                        Checkbox(
                          value: AppLocalizations.of(context)
                                      .translate('locale') ==
                                  'en'
                              ? true
                              : false,
                          onChanged: (value) {
                            dataLang.changeLanguage(Locale("en"));
                          },
                        ),
                        Text(
                          'English',
                          style: TextStyle(
                              fontSize: responsiveHeight(18),
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: AppLocalizations.of(context)
                                      .translate('locale') ==
                                  'pt'
                              ? true
                              : false,
                          onChanged: (value) {
                            dataLang.changeLanguage(Locale("pt"));
                          },
                        ),
                        Text(
                          'Português',
                          style: TextStyle(
                            fontSize: responsiveHeight(18),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: AppLocalizations.of(context)
                                      .translate('locale') ==
                                  'es'
                              ? true
                              : false,
                          onChanged: (value) {
                            dataLang.changeLanguage(Locale("es"));
                          },
                        ),
                        Text(
                          'Español',
                          style: TextStyle(
                            fontSize: responsiveHeight(18),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: AppLocalizations.of(context)
                                      .translate('locale') ==
                                  'de'
                              ? true
                              : false,
                          onChanged: (value) {
                            dataLang.changeLanguage(Locale("de"));
                          },
                        ),
                        Text(
                          'Deutsch',
                          style: TextStyle(
                            fontSize: responsiveHeight(18),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: AppLocalizations.of(context)
                                      .translate('locale') ==
                                  'fr'
                              ? true
                              : false,
                          onChanged: (value) {
                            dataLang.changeLanguage(Locale("fr"));
                          },
                        ),
                        Text(
                          'Français',
                          style: TextStyle(
                            fontSize: responsiveHeight(18),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
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
