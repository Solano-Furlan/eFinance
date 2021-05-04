import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import 'line_chart.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CalculatorProvider>(context);
    final colors = [Colors.cyan.value, Colors.red.value];
    var height = MediaQuery.of(context).size.height;
    final values = [50.0, 50.0];
    double responsiveHeight(pixels) {
    return height * (pixels / 725);
  }

    return Container(
      height: height - (height * 0.15) - kBottomNavigationBarHeight,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: LineChartSample1(),
          ),
          Container(
            padding: EdgeInsets.only(top: responsiveHeight(10)),
            width: MediaQuery.of(context).size.width,
            height: height * 0.4,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(responsiveHeight(35)),
                topRight: Radius.circular(responsiveHeight(35)),
              ),
            ),
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: height * 0.004,
                centerSpaceRadius: 0,
                sections: List.generate(
                  2,
                  (i) {
                    final double fontSize =
                        height * 0.021;
                    final double radius =
                        height * 0.167;
                    return PieChartSectionData(
                      color: Color(colors[i]),
                      value: data.monthlyPayment == 0
                          ? values[i]
                          : data.chartValues[i],
                      title:
                          data.monthlyPayment == 0 || data.monthlyPayment.isNaN
                              ? ''
                              : data.chartValues[i].toStringAsFixed(0) + '%',
                      radius: radius,
                      titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffffffff)),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
