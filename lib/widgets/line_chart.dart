import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../app_localization.dart';

class LineChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CalculatorProvider>(context);
    String interest = AppLocalizations.of(context).translate('interest');
    var height = MediaQuery.of(context).size.height;
    double responsiveHeight(pixels) {
      return height * (pixels / 725);
    }
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(responsiveHeight(18)),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: responsiveHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          shape: BoxShape.circle,
                        ),
                        height: responsiveHeight(16),
                        width: responsiveHeight(16),
                      ),
                      Text(
                        ' ' +
                            AppLocalizations.of(context)
                                .translate('principal')
                                .toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: responsiveHeight(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: responsiveHeight(30)),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        height: responsiveHeight(16),
                        width: responsiveHeight(16),
                      ),
                      Text(
                        ' ' +
                            interest
                                .substring(0, interest.length - 1)
                                .toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: responsiveHeight(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: responsiveHeight(16), left: responsiveHeight(6)),
                    child: LineChart(
                      sampleData(context),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                 SizedBox(
                  height: responsiveHeight(10),
                ),
              ],
            ),
            Positioned(
              bottom: responsiveHeight(12),
              child: Container(
                margin: EdgeInsets.only(left: responsiveHeight(20), right: responsiveHeight(20)),
                width: MediaQuery.of(context).size.width - responsiveHeight(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      data.date.year.toString(),
                      style: TextStyle(
                        color: Color(0xff72719b),
                        fontWeight: FontWeight.bold,
                        fontSize: responsiveHeight(16),
                      ),
                    ),
                    Text(
                      data.totalOfPayments == 36
                          ? (data.date.year + 1).toString()
                          : data.totalOfPayments > 12
                              ? (data.date.year +
                                      (data.totalOfPayments / 12 / 2))
                                  .toStringAsFixed(0)
                              : '',
                      style: TextStyle(
                        color: Color(0xff72719b),
                        fontWeight: FontWeight.bold,
                        fontSize: responsiveHeight(16),
                      ),
                    ),
                    Text(
                      data.years == 0
                          ? (data.date.year + 1).toString()
                          : (data.date.year + data.totalOfPayments / 12)
                              .toStringAsFixed(0),
                      style: TextStyle(
                        color: Color(0xff72719b),
                        fontWeight: FontWeight.bold,
                        fontSize: responsiveHeight(16),
                      ),
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

  LineChartData sampleData(BuildContext context) {
    final data = Provider.of<CalculatorProvider>(context);
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            return '';
          },
          margin: 14,
          reservedSize: 0,
          interval: 20,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: data.totalOfPayments == 0 ? 12 : data.totalOfPayments,
      maxY: data.monthlyPayment == 0 ? 500 : data.monthlyPayment,
      minY: 0,
      lineBarsData: linesBarData1(context),
    );
  }

  List<LineChartBarData> linesBarData1(BuildContext context) {
    final data = Provider.of<CalculatorProvider>(context);
    var height = MediaQuery.of(context).size.height;
    double responsiveHeight(pixels) {
      return height * (pixels / 725);
    }
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: List.generate(
        (data.years == 0 ? 12 : data.totalOfPayments).toInt(),
        (index) => FlSpot(
            index.toDouble(),
            data.years == 0
                ? (365 - index * 3 * index).toDouble()
                : data.interestPerMonth[index]),
      ),
      isCurved: true,
      colors: [Colors.red],
      barWidth: responsiveHeight(4),
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: List.generate(
        (data.years * 12 == 0 ? 12 : data.totalOfPayments).toInt(),
        (index) => FlSpot(
            index.toDouble(),
            data.years * 12 == 0
                ? (index * 3 * index).toDouble()
                : data.monthlyPayment - data.interestPerMonth[index]),
      ),
      isCurved: true,
      colors: [
        Colors.cyan,
      ],
      barWidth: responsiveHeight(4),
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
    ];
  }
}
