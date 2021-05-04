import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../app_localization.dart';

class Payments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CalculatorProvider>(context);
    final oCcy = new NumberFormat("#,##0.00", AppLocalizations.of(context).translate('locale'));
    String interest = AppLocalizations.of(context).translate('interest');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    double responsiveHeight(pixels) {
      return height * (pixels / 725);
    }

    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: data.date,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      int i;
      for (i = 0; i <= data.years * 12; i++) {}
      if (picked != null && picked != data.date) {
        data.changeDate(picked);
      }
    }

    return Container(
      height: height - (height * 0.15) - kBottomNavigationBarHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(responsiveHeight(35)),
          topRight: Radius.circular(responsiveHeight(35)),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(responsiveHeight(35)),
                topRight: Radius.circular(responsiveHeight(35)),
              )),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: data.monthlyPayment == 0
                      ? 12
                      : data.totalOfPayments.toInt(),
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: responsiveHeight(15),
                          right: responsiveHeight(15)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: width * 0.325 - responsiveHeight(30),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (i + 1).toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveHeight(18),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              i == 0
                                  ? RaisedButton(
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                      color: Colors.white,
                                      child: Container(
                                        width:
                                            width * 0.35 - responsiveHeight(30),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.center,
                                          child: Text(
                                            DateFormat('MM/dd/yyyy').format(
                                                DateTime(
                                                    data.date.year,
                                                    data.date.month,
                                                    data.date.day)),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: responsiveHeight(18),
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width:
                                          width * 0.35 - responsiveHeight(30),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.center,
                                        child: Text(
                                          DateFormat('MM/dd/yyyy').format(
                                              DateTime(
                                                  data.date.year,
                                                  data.date.month + i,
                                                  data.date.day)),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: responsiveHeight(18),
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                              Container(
                                width: width * 0.325 - responsiveHeight(30),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    AppLocalizations.of(context)
                                            .translate('currency') +
                                        oCcy.format(data.monthlyPayment),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveHeight(18),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: responsiveHeight(20)),
                          i > 0
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(
                                      bottom: responsiveHeight(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('principal')
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsiveHeight(18),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        interest
                                            .toUpperCase()
                                            .substring(0, interest.length - 1),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsiveHeight(18),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      shape: BoxShape.circle,
                                    ),
                                    height: responsiveHeight(16),
                                    width: responsiveHeight(16),
                                  ),
                                  Container(
                                    width: width * 0.5 - responsiveHeight(62),
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        data.interest == 0
                                            ? ' ' +
                                                AppLocalizations.of(context)
                                                    .translate('currency') +
                                                oCcy.format(data.monthlyPayment)
                                            : ' ' +
                                                AppLocalizations.of(context)
                                                    .translate('currency') +
                                                oCcy.format((data
                                                        .monthlyPayment -
                                                    data.interestPerMonth[i])),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsiveHeight(18),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    height: responsiveHeight(16),
                                    width: responsiveHeight(16),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: width * 0.5 - responsiveHeight(62),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        data.interest == 0
                                            ? ' ' +
                                                AppLocalizations.of(context)
                                                    .translate('currency') +
                                                '0.00'
                                            : ' ' +
                                                AppLocalizations.of(context)
                                                    .translate('currency') +
                                                oCcy.format(
                                                    data.interestPerMonth[i]),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsiveHeight(18),
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                            height: responsiveHeight(30),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
