import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../widgets/payments_section.dart';
import '../widgets/calculator_section.dart';
import '../widgets/chart_section.dart';
import '../widgets/amortization.dart';
import '../widgets/drawer.dart';

class Home extends StatefulWidget {
  static const routeName = 'home-page';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  var isInit = true;
  @override
  void didChangeDependencies() {
    if (!isInit) {
      return;
    }
    isInit = false;
    Provider.of<LanguageProvider>(context).fetchLocale();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    didChangeDependencies();
    var height = MediaQuery.of(context).size.height;
    double responsiveHeight(pixels) {
      return height * (pixels / 725);
    }

    return isInit == true ? Container() :Scaffold(
      drawer: DrawerMenu(),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: height,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: height * 0.15,
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
                                Icons.menu,
                                color: Colors.black,
                                size: responsiveHeight(26),
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                            Text(
                              'eFinance',
                              style: TextStyle(
                                fontSize: responsiveHeight(33),
                                fontWeight: FontWeight.w300,
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
                    _currentIndex == 0
                        ? Calculator()
                        : _currentIndex == 1
                            ? Chart()
                            : _currentIndex == 2
                                ? Payments()
                                : Amortization(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: responsiveHeight(24)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline, size: responsiveHeight(24)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: responsiveHeight(24)),
            label: '',
          ),
        ],
      ),
    );
  }
}
