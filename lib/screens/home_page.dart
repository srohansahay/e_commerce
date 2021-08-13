import 'package:e_commerce/tabs/home_tab.dart';
import 'package:e_commerce/tabs/saved_tab.dart';
import 'package:e_commerce/tabs/search_tab.dart';
import 'package:e_commerce/widgets/bottomtabs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 late PageController _tabsPageController;
  int _selectedtab = 0;

  @override
  void initState() {
    // TODO: implement initState
    _tabsPageController = PageController();
    super.initState();
  }

 @override
  void dispose() {
    // TODO: implement dispose
   _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedtab = num;
                });
              },
              children:[
               HomeTab(),
                SearchTab(),
                SavedTab(),
              ]
            ),
          ),
        BottomTab(
          isSelectedtab: _selectedtab,
          onTabPressed: (num) {
            _tabsPageController.animateToPage(num, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
          },),
        ],
      ),
    );
  }
}
