import 'package:flutter/material.dart';
import '../app_localization.dart';

class RateUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(

      title: Row(
        children: <Widget>[
          Text(
            AppLocalizations.of(context).translate('rate-us'),
            style: TextStyle(
              fontSize: height * 0.03,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          GestureDetector(
            child: Icon(Icons.close, color: Colors.black.withOpacity(.65),),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      content: GestureDetector(
        onTap: () {
          print('Rate Us');
        },
        child: Container(
          color: Colors.white,
          height: height * 0.175,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('rate-us-text'),
                style: TextStyle(color: Colors.black54, fontSize: height * 0.025,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.all(height * 0.01),
                    child: Icon(
                      Icons.star_border,
                      color: Theme.of(context).primaryColor,
                      size: height * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
