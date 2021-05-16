import 'package:flutter/material.dart';

import './rate_us.dart';
import './about.dart';
import '../pages/settings.dart';
import '../app_localization.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.84,
      child: Drawer(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(0),
          child: Container(
            color: Colors.white,
            height: height,
            width: width * 0.77,
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).padding.top,
                  color: Theme.of(context).primaryColorDark,
                ),
                Container(
                  height: height * 0.213,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                height: height * 0.0733,
                                width: height * 0.0733,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                child: ClipOval(
                                  child: Image.asset('assets/icon/icon2.png'),
                                )),
                            SizedBox(height: height * 0.006),
                            Text(
                              'eFinance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                _drawerButtons(context, Icons.settings, Colors.black26,
                    AppLocalizations.of(context).translate('settings'), () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Settings.routeName);
                }),
                Divider(height: 0, thickness: 1),
                _drawerButtons(
                    context,
                    Icons.star_border,
                    Theme.of(context).primaryColor,
                    AppLocalizations.of(context).translate('rate-us'), () {
                  Navigator.of(context).pop();
                  return showDialog(
                      context: context,
                      builder: ((context) {
                        return RateUs();
                      }));
                }),
                Divider(height: 0, thickness: height * 0.0013),
                _drawerButtons(context, Icons.info, Colors.black26,
                    AppLocalizations.of(context).translate('about'), () {
                  Navigator.of(context).pop();
                  return showDialog(
                      context: context,
                      builder: ((context) {
                        return About();
                      }));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerButtons(BuildContext context, IconData icon, Color color, title,
      Function function) {
    var height = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.black.withOpacity(.07),
        onTap: function,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: height * (15 / height),
              vertical: height * (16 / height)),
          child: Center(
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: MediaQuery.of(context).size.height * 0.033,
                  color: color,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.071),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.65),
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
