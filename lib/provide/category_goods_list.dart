import 'package:flutter/material.dart';
import 'package:flutter_shop/model/mallGoods.dart';

class CategoryGoodsList with ChangeNotifier{
  
  List<Goods> goodsList = [];

      //点击大类时更换商品列表
    getGoodsList(List<Goods> list){
      goodsList=list;   
      notifyListeners();
    }

}