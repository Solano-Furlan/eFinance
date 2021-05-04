import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import '../app_localization.dart';
import '../providers/calculator_provider.dart';
import 'results.dart';
import '../helpers/currency_formatter.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CalculatorProvider>(context);
    final oCcy = new NumberFormat("#,##0.00", AppLocalizations.of(context).translate('locale'));
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    double responsiveHeight(pixels) {
      return height * (pixels / 725);
    }

    var _downPaymentController = TextEditingController(
        text: data.downPayment == 0
            ? ''
            : AppLocalizations.of(context).translate('currency') +
                oCcy.format(data.downPayment));
    _downPaymentController.selection = TextSelection.fromPosition(
        TextPosition(offset: _downPaymentController.text.length));

    var _totalAmountController = TextEditingController(
        text: data.totalAmount == 0
            ? ''
            : AppLocalizations.of(context).translate('currency') +
                oCcy.format(data.totalAmount));
    _totalAmountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _totalAmountController.text.length));

    var _amortizationController = TextEditingController(
        text: data.amortization == 0
            ? ''
            : AppLocalizations.of(context).translate('currency') +
                oCcy.format(data.amortization));
    _amortizationController.selection = TextSelection.fromPosition(
        TextPosition(offset: _amortizationController.text.length));

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: height - (height * 0.15) - kBottomNavigationBarHeight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: responsiveHeight(15),
                        right: responsiveHeight(15)),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _totalAmountController,
                            style: TextStyle(fontSize: responsiveHeight(16)),
                            onChanged: (newValue) {
                              data.updateDownPayment('0.00');
                              data.updateTotalAmount(newValue);
                              data.calculateMonthlyPayment();
                            },
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('total-amount'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(responsiveHeight(30)),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white70,
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          SizedBox(height: responsiveHeight(20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: width / 2 - responsiveHeight(25),
                                child: TextFormField(
                                  controller: _downPaymentController,
                                  style:
                                      TextStyle(fontSize: responsiveHeight(16)),
                                  maxLength: data.totalAmount
                                      .toStringAsFixed(3)
                                      .length,
                                  keyboardType: TextInputType.number,
                                  onChanged: (newValue) {
                                    String formatedDownPayment;
                                    formatedDownPayment = newValue.replaceAll(
                                        RegExp(r'[^0-9]'), '');
                                    if ((double.parse(formatedDownPayment) /
                                            100) >
                                        data.totalAmount) {
                                      data.updateDownPayment(
                                          data.downPayment.toStringAsFixed(2));
                                      return;
                                    }
                                    data.updateDownPayment(newValue);
                                    data.calculateMonthlyPayment();
                                  },
                                  decoration: InputDecoration(
                                      counter: Offstage(),
                                      labelText: AppLocalizations.of(context)
                                          .translate('down-payment'),
                                      // labelStyle: TextStyle(fontSize: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(responsiveHeight(30)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white70,
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                              SizedBox(width: responsiveHeight(15)),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTickMarkColor:
                                        Theme.of(context).primaryColor,
                                    inactiveTickMarkColor:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                  child: Slider(
                                    value: (data.downPayment == 0 ||
                                            data.totalAmount == 0)
                                        ? 0
                                        : (data.downPayment /
                                                data.totalAmount) *
                                            100,
                                    onChanged: (newValue) {
                                      data.updateDownPaymentPercetage(newValue);
                                      data.calculateMonthlyPayment();
                                    },
                                    min: 0,
                                    max: 100,
                                    divisions: 20,
                                    label: ((data.downPayment == 0 ||
                                                    data.totalAmount == 0)
                                                ? 0
                                                : (data.downPayment /
                                                        data.totalAmount) *
                                                    100)
                                            .toStringAsFixed(0) +
                                        '%',
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: responsiveHeight(20)),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style:
                                      TextStyle(fontSize: responsiveHeight(16)),
                                  initialValue: data.years == 0
                                      ? ''
                                      : data.years.toStringAsFixed(0),
                                  onChanged: (newValue) {
                                    data.updateYears(newValue);
                                    data.calculateMonthlyPayment();
                                  },
                                  maxLength: 2,
                                  decoration: InputDecoration(
                                      counter: Offstage(),
                                      labelText: AppLocalizations.of(context)
                                          .translate('years'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(responsiveHeight(30)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white70,
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                              SizedBox(width: responsiveHeight(20)),
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style:
                                      TextStyle(fontSize: responsiveHeight(16)),
                                  initialValue: data.interest == 0
                                      ? ''
                                      : data.interest.toStringAsFixed(2),
                                  onChanged: (newValue) {
                                    data.updateInterest(newValue);
                                    data.calculateMonthlyPayment();
                                  },
                                  maxLength: 4,
                                  decoration: InputDecoration(
                                      counter: Offstage(),
                                      labelText: AppLocalizations.of(context)
                                          .translate('interest'),
                                      suffixText: '%/' +
                                          AppLocalizations.of(context)
                                              .translate('year'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(responsiveHeight(30)),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white70,
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: responsiveHeight(20)),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _amortizationController,
                            style: TextStyle(fontSize: responsiveHeight(16)),

                            inputFormatters: [
                              // WhitelistingTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              CurrencyInputFormatter()
                            ],
                            // initialValue: data.amortization == 0 ? '' : AppLocalizations.of(context).translate('currency') + oCcy.format(data.amortization),
                            onChanged: (newValue) {
                              if (data.monthlyPayment > 0) {
                                data.updateAmortization(newValue);
                              }
                              data.calculateMonthlyPayment();
                            },
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('monthly-amortization'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(responsiveHeight(30)),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white70,
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: responsiveHeight(200),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(responsiveHeight(35)),
                        topRight: Radius.circular(responsiveHeight(35)),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: responsiveHeight(30),
                          right: responsiveHeight(30),
                          top: responsiveHeight(30)),
                      child: Column(children: <Widget>[
                        results(
                            AppLocalizations.of(context)
                                .translate('total-of-payments'),
                            data.totalOfPayments.toStringAsFixed(0),
                            context),
                        Divider(
                          color: Colors.white,
                          height: responsiveHeight(20),
                        ),
                        results(
                            AppLocalizations.of(context)
                                .translate('monthly-payment'),
                            AppLocalizations.of(context).translate('currency') +
                                oCcy.format(data.monthlyPayment),
                            context),
                        Divider(
                          color: Colors.white,
                          height: responsiveHeight(20),
                        ),
                        results(
                            AppLocalizations.of(context)
                                .translate('total-interest'),
                            data.monthlyPayment == 0
                                ? AppLocalizations.of(context)
                                        .translate('currency') +
                                    '0.00'
                                : AppLocalizations.of(context)
                                        .translate('currency') +
                                    oCcy.format(((data.monthlyPayment *
                                                data.totalOfPayments) -
                                            (data.totalAmount -
                                                data.downPayment)) +
                                        data.difference),
                            context),
                        Divider(
                          color: Colors.white,
                          height: responsiveHeight(20),
                        ),
                        results(
                            AppLocalizations.of(context)
                                .translate('total-payment'),
                            AppLocalizations.of(context)
                                    .translate('currency') +
                                oCcy.format(((data.monthlyPayment *
                                        data.totalOfPayments) +
                                    data.difference)),
                            context),
                      ]),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
