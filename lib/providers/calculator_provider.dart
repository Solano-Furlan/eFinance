import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorProvider with ChangeNotifier {
  double _totalAmount = 0.0;

  double get totalAmount {
    return _totalAmount;
  }

  double _downPayment = 0.0;

  double get downPayment {
    return _downPayment;
  }

  double _years = 0.0;

  double get years {
    return _years;
  }

  double _interest = 0.0;

  double get interest {
    return _interest;
  }

  double _monthlyPayment = 0.0;

  double get monthlyPayment {
    return _monthlyPayment;
  }

  DateTime _date = DateTime.now();

  DateTime get date {
    return _date;
  }

  List _interestPerMonth = [];

  List get interestPerMonth {
    return _interestPerMonth;
  }

  double _totalOfPayments = 0;

  double get totalOfPayments {
    return _totalOfPayments;
  }

  List _chartValues = [];

  List get chartValues {
    return _chartValues;
  }

  double _amortization = 0.0;

  double get amortization {
    return _amortization;
  }

  double _totalInterest = 0.0;

  double get totalInterest {
    return _totalInterest;
  }

  double _difference = 0.0;

  double get difference {
    return _difference;
  }

  void changeDate(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  void calculateInrestPerMonth() {
    _totalInterest = 0;
    int i;
    double _loanAmount = _totalAmount - _downPayment;
    for (i = 0; i < _totalOfPayments; i++) {
      double result = _interest / 1200 * _loanAmount;
      _loanAmount = _loanAmount - (_monthlyPayment - result) - _amortization;
      if (result.isNegative) {
        result = 0;
      }
      _totalInterest = _totalInterest + result;
      _interestPerMonth.add(result);
    }
    notifyListeners();
    print('$_totalInterest eeee');
  }

  void calculateAmortizationAdjust() {
    double _loanAmount = _totalAmount - _downPayment;
    if (_amortization <= 0) {
      print('FFFFFF');
      _totalOfPayments = _years * 12;
      return;
    }
    print('FGHHHHHh');
    _totalOfPayments = 0;
    while (_loanAmount > 0) {
      _totalOfPayments = _totalOfPayments + 1;
      final result = _interest / 1200 * _loanAmount;
      _loanAmount = _loanAmount - (_monthlyPayment - result);
      if (_loanAmount.isNegative) {
        _difference = _loanAmount;
      }
    }
    notifyListeners();
  }

  void calculateChartValues() {
    final totalInterest = (_monthlyPayment * _totalOfPayments) -
        (_totalAmount - _downPayment) -
        difference;
    final totalPayment = _monthlyPayment * _totalOfPayments - difference;
    final values = [
      totalPayment == 0 || totalPayment.isNaN
          ? 50.0
          : (100 - (totalInterest / (totalPayment)) * 100),
      totalPayment == 0 || totalPayment.isNaN
          ? 50.0
          : (totalInterest / (totalPayment)) * 100
    ];
    _chartValues = values;

    notifyListeners();
  }

  void calculateMonthlyPayment() {
    if ((_totalAmount - _downPayment) < 0 ||
        _totalOfPayments <= 0 ||
        _interest < 0) {
      return;
    }
    if (_interest == 0) {
      _monthlyPayment = (_totalAmount - _downPayment) / _totalOfPayments;
    }
    _monthlyPayment = 0;
    if (_interest == 0) {
      _monthlyPayment =
          ((_totalAmount - _downPayment) / _totalOfPayments) + _amortization;
      _interestPerMonth = [];
      calculateInrestPerMonth();
      calculateChartValues();
      calculateAmortizationAdjust();
      notifyListeners();

      return;
    }
    _monthlyPayment = (((_totalAmount - _downPayment) *
                ((_interest / 1200) *
                    pow((1 + (_interest / 1200)), (years * 12)))) /
            (pow((1 + (_interest / 1200)), (years * 12)) - 1)) +
        _amortization;
    _interestPerMonth = [];

    calculateInrestPerMonth();
    calculateChartValues();
    calculateAmortizationAdjust();
    notifyListeners();
  }

  void updateTotalAmount(String newValue) {
    newValue = newValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (double.tryParse(newValue) == null || newValue.isEmpty) {
      return;
    }
    _totalAmount = double.parse(newValue) / 100;
    _amortization = 0;
    _difference = 0.0;

    notifyListeners();
  }

  void updateDownPayment(String newValue) {
    newValue = newValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (double.tryParse(newValue) == null) {
      return;
    }
    _downPayment = double.parse(newValue) / 100;
    _amortization = 0;
    _difference = 0.0;
    notifyListeners();
  }

  void updateDownPaymentPercetage(double newValue) {
    _downPayment = _totalAmount * (newValue / 100);
    print(downPayment);
    _amortization = 0;
    _difference = 0.0;

    notifyListeners();
  }

  void updateYears(String newValue) {
    if (double.tryParse(newValue) == null) {
      return;
    }
    _years = double.parse(newValue);
    _totalOfPayments = _years * 12;
    _amortization = 0;
    _difference = 0.0;
    calculateInrestPerMonth();
    notifyListeners();
  }

  void updateInterest(String newValue) {
    if (double.tryParse(newValue) == null) {
      return;
    }
    _interest = double.parse(newValue);
    _amortization = 0;
    _difference = 0.0;
    notifyListeners();
  }

  void updateAmortization(String newValue) {
    newValue = newValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (double.tryParse(newValue) == null) {
      print('Hello there');
      return;
    }

    if ((_totalAmount - _downPayment) < (double.parse(newValue) / 100)) {
      return;
    }
    _amortization = double.parse(newValue) / 100;
    _difference = 0.0;

    notifyListeners();

    calculateMonthlyPayment();
    calculateAmortizationAdjust();
    print(_amortization.toString() + 'DDDDDDD');
  }
}
