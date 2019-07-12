import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import '../model/details.dart';
import '../pages/details/details_top_area.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../pages/details/details_tab.dart';
import '../pages/details/details_bottom_shop_car.dart';

import '../pages/details/details_content.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            //返回按钮
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('商品详情'),
        ),
        body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[

                  Container(
                    child: ListView(
                      children: <Widget>[
                        DetailsTopArea(),
                        DetailsTab(),
                        DetailsContent(),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: DetailsBottom(),
                  )
                ],
              );
            } else {
              return Center(
                child: Text('加载中...'),
              );
            }
          },
        ));
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '加载完毕';
  }
}
