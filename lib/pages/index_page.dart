import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'shop_car_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/current_index.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];
  final List<Widget> tabsPages = [
    HomePage(),
    CategoryPage(),
    ShopCarPage(),
    MemberPage()
  ];

  int currentIndex = 0;
  var cuttentPage;

  @override
  void initState() {
    cuttentPage = tabsPages[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =ScreenUtil(width: 750,height: 1334)..init(context);

    return Provide<CurrentIndexProvide>(
      builder: (context,child,val){
        int currentIndex= Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 1, 0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabsPages,

      )
    );
      },
    );
    
    
   
  }
}
