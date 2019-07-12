import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/shopCartInfo.dart';

class ShopCarProvide extends ChangeNotifier {
  String carString = '[]';
  List<ShopCartInfo> cartInfoList = [];
  num allPrice = 0;
  int allGoodCount = 0;
  bool isAllCheck = true;

/**
 * 加入购物车的操作
 */
  void save(goodsId, goodsName, count, price, images, oldPrice, isCheck) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    carString = sp.getString('cartInfo');
    var temp = carString == null ? [] : jsonDecode(carString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false; //是否已经存在
    int index = 0; //foreach循环的索引
    allPrice = 0;
    allGoodCount = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[index]['count'] = item['count'] + 1;
        cartInfoList[index].count++;
        isHave = true;
      }
         if(item['isCheck']){
         allPrice+= (cartInfoList[index].price* cartInfoList[index].count);
         allGoodCount+= cartInfoList[index].count;
      }
      index ++;
    });
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'oldPrice': oldPrice,
        'isCheck': isCheck
      };
      tempList.add(newGoods);
      cartInfoList.add(ShopCartInfo.fromJson(newGoods)); // map to dart;
allPrice+= (count * price);
      allGoodCount+=count;
    }
    //把字符串进行encode操作，
    carString = json.encode(tempList).toString();

    sp.setString('cartInfo', carString); //进行持久化
    notifyListeners();
  }

  void remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cartInfo');
    cartInfoList = [];
    allPrice =0 ;
    allGoodCount=0;
    print('~~~~~~~~~~~~~~~~~~~~~~清空购物车~~~~~~~~~~~~~~~~~~~~~~~~~');
    notifyListeners();
  }

  void getCartInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    carString = sp.getString('cartInfo'); //获得购物车中的商品,这时候是一个字符串
    //把cartList进行初始化，防止数据混乱
    cartInfoList = [];
    //判断得到的字符串是否有值，如果不判断会报错
    if (carString == null) {
      cartInfoList = [];
    } else {
      List<Map> tempList = (json.decode(carString.toString()) as List).cast();
      allGoodCount = 0;
      allPrice = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += item['count'] * item['price'];
          allGoodCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartInfoList.add(new ShopCartInfo.fromJson(item));
      });
    }
    notifyListeners();
  }

/*
 * 删除一条商品
 */
  void deleteGoods(goodsId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    carString = sp.getString('cartInfo'); //获得购物车中的商品,这时候是一个字符串
    List<Map> tempList = (json.decode(carString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);

    //把字符串进行encode操作，
    carString = json.encode(tempList).toString();
    sp.setString('cartInfo', carString); //进行持久化
    await getCartInfo();
  }

/*
 * 改变数量
 */
  void changeCheckState(ShopCartInfo info) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    carString = sp.getString('cartInfo'); //获得购物车中的商品,这时候是一个字符串
    List<Map> tempList = (json.decode(carString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == info.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = info.toJson();
    carString = json.encode(tempList).toString();
    sp.setString('cartInfo', carString);
    await getCartInfo();
  }

/*
* 全选状态改变
*/
  void changeAllCheckButton(bool isCheck) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    carString = sp.getString('cartInfo'); //获得购物车中的商品,这时候是一个字符串
    List<Map> tempList = (json.decode(carString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    carString = json.encode(newList).toString();
    sp.setString('cartInfo', carString);
    await getCartInfo();
  }

/*
* 商品加减
*/
  void addOrReduceGood(var curItem, String todo) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    carString = sp.getString('cartInfo'); //获得购物车中的商品,这时候是一个字符串
    List<Map> tempList = (json.decode(carString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == curItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      curItem.count++;
    } else if (curItem.count > 1) {
      curItem.count--;
    }
    tempList[changeIndex] = curItem.toJson();
    carString = json.encode(tempList).toString();
    sp.setString('cartInfo', carString);
    await getCartInfo();
  }
}
