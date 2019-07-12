import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex  = 0;//子类索引
  int page = 1;//商品加载页
  
  String categoryId = '4';  //左侧菜单id 

  String categorySubId = ''; //右侧顶部子菜单Id


//大类切换效果
  getChildCategory(List<BxMallSubDto> list,String categoryId) {
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallSubName = '全部';
    all.mallCategoryId = '';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    childIndex = 0;
    this.categoryId = categoryId;
    this.categorySubId = '';
    page = 1;
    notifyListeners();
  }

  //改变子类索引
    chageChildIndex(int index){
      childIndex =index;
      notifyListeners();
    }


  //改变子类索引
    chagePage(int pages){
      page = pages;
      notifyListeners();
    }

  //改变子类索引
    chageCategorySubId(String id){
      categorySubId = id;
      notifyListeners();
    }

}
