import 'package:flutter/material.dart';
import '../app_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    double responsiveHeight(pixels) {
      return height * (pixels / 725);
    }

    _launchURL() async {
      const url = 'https://www.linkedin.com/in/solano-furlan-3a931220b/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return AlertDialog(
      title: Text('eFinance'),
      contentPadding: EdgeInsets.only(
        left: responsiveHeight(15),
        right: responsiveHeight(15),
        top: responsiveHeight(20),
      ),
      content: Container(
        height: responsiveHeight(70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('version') + ' 1.05',
              style: TextStyle(
                fontSize: responsiveHeight(18),
              ),
            ),
            SizedBox(height: responsiveHeight(10)),
            GestureDetector(
              onTap: () {
                print('URL');
                _launchURL();
              },
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('developer'),
                      style: TextStyle(
                        fontSize: responsiveHeight(18),
                      ),
                    ),
                    Text(
                      ' Solano Furlan',
                      style: TextStyle(
                        fontSize: responsiveHeight(18),
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.black12,
          child: Text(
            'OK',
            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: responsiveHeight(16)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
