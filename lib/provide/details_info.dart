import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;

// tabar 切换的方法
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

//从后台获取商品
  getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((val) {
      var requestResult = json.decode(val.toString());
      print(requestResult);
      goodsInfo = DetailsModel.fromJson(requestResult);
      notifyListeners();
    });
  }

//从后台获取商品
  upGoodsInfo(goodsInfos) {
    this.goodsInfo = goodsInfos;
  }
}
