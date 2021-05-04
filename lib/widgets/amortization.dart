import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../providers/calculator_provider.dart';
import '../helpers/currency_formatter.dart';
import 'amortization_results.dart';

class Amortization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CalculatorProvider>(context);
    final oCcy = new NumberFormat("#,##0.00");

    int years = data.amortization > 0
        ? (data.totalOfPayments / 12).floor()
        : data.years.toInt();
    int months = data.amortization > 0 ? (data.totalOfPayments / 12).floor() <
            data.totalOfPayments / 12
        ? data.totalOfPayments - (years * 12)
        : 0 : 0;

    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [
                  //   WhitelistingTextInputFormatter.digitsOnly,
                  //   CurrencyInputFormatter()
                  // ],
                  initialValue: '\$' + oCcy.format(data.amortization),
                  onChanged: (newValue) {
                    if (data.monthlyPayment > 0) {
                      data.updateAmortization(newValue);
                      data.calculateAmortizationAdjust();
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Monthly Amortization',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
                SizedBox(height: 15),
                amortizationResults(
                    'Total # Of Payments:  ',
                    data.amortization > 0
                        ? data.totalOfPayments.toString()
                        : (data.years * 12).toStringAsFixed(0)),
                amortizationResults(
                    'Monthly Payment:  ',
                    '\$' +
                        oCcy.format((data.monthlyPayment + data.amortization))),
                amortizationResults(
                    'Total Interest:  ',
                    data.amortization > 0
                        ? '\$' +
                            oCcy.format(
                                ((data.monthlyPayment + data.amortization) *
                                        data.totalOfPayments) -
                                    (data.totalAmount - data.downPayment) + data.difference)
                        : data.monthlyPayment == 0
                            ? '\$0.00'
                            : '\$' +
                                oCcy.format(
                                    (data.monthlyPayment * data.years * 12) -
                                        (data.totalAmount - data.downPayment))),
                amortizationResults(
                    'Total Payment:  ',
                    data.amortization > 0
                        ? '\$' +
                            oCcy.format(
                                (data.monthlyPayment + data.amortization) *
                                    data.totalOfPayments + data.difference)
                        : '\$' +
                            oCcy.format(data.monthlyPayment * data.years * 12)),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 70),
          height: MediaQuery.of(context).size.height * 0.217,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              months == 0
                  ? 
                  data.amortization > 0
                      ? years.toStringAsFixed(0) + ' Years '
                      : years.toStringAsFixed(0) + ' Years '
                  : data.amortization > 0
                      ? years.toStringAsFixed(0) +
                          ' Years and ' +
                          months.toStringAsFixed(0) +
                          ' Months'
                      : years.toStringAsFixed(0) +
                          ' Years and ' +
                          months.toStringAsFixed(0) +
                          ' Months',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
