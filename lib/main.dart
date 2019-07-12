import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/pages/time_line_page.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/current_index.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_cateogry.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';
import './provide/details_info.dart';
import './provide/shop_car.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var goodsList = CategoryGoodsList();
  var providers = Providers();
  var detailsInfoProvide = DetailsInfoProvide();
  var shopCar = ShopCarProvide();
  var currentIndex = CurrentIndexProvide();
  providers
  ..provide(Provider<Counter>.value(counter))
  ..provide(Provider<ChildCategory>.value(childCategory))
  ..provide(Provider<CategoryGoodsList>.value(goodsList))
  ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
  ..provide(Provider<CurrentIndexProvide>.value(currentIndex))
  ..provide(Provider<ShopCarProvide>.value(shopCar));

  runApp(ProviderNode(child: MyApp(),providers: providers,));
  
 // 添加如下代码，使状态栏透明
  if (Platform.isAndroid) {
    var style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final router = Router();
  Routers.configRouters(router);
  Application.router = router;
    return Container(
        child: MaterialApp(
          onGenerateRoute: Application.router.generator,
      title: "百姓生活家",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.pink),
      home: IndexPage(),
    ));
  }
}
