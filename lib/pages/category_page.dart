import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:provide/provide.dart';
import '../provide/child_cateogry.dart';
import '../model/mallGoods.dart';
import '../provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../routers/application.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商品分类'),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              LeftCategoryNav(),
              Column(
                children: <Widget>[
                  RightCategoryNav(),
                  Content(
                    mContext: context,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    // getMallGoods(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            border: Border(
          right: BorderSide(width: 1, color: Colors.black12),
        )),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          },
        ));
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
        onTap: () {
          setState(() {
            listIndex = index;
          });
          var childList = list[index].bxMallSubDto;
          var categoryId = list[index].mallCategoryId;
          Provide.value<ChildCategory>(context)
              .getChildCategory(childList, categoryId);
          Provide.value<ChildCategory>(context).chagePage(1);
          getMallGoods(context);
        },
        child: Container(
          height: ScreenUtil().setHeight(100),
          padding: EdgeInsets.only(left: 10, top: 20),
          decoration: BoxDecoration(
              color:
                  isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              )),
          child: Text(
            list[index].mallCategoryName,
            style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          ),
        ));
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            // border:
            //     Border(bottom: BorderSide(width: 1, color: Colors.black12))
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return Center(
                child:
                    rigthInkWell(childCategory.childCategoryList[index], index),
              );
            },
          ),
        );
      },
    );
  }

//item
  Widget rigthInkWell(BxMallSubDto item, int index) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .chageCategorySubId(item.mallSubId);
        Provide.value<ChildCategory>(context).chageChildIndex(index);
        Provide.value<ChildCategory>(context).chagePage(1);
        getMallGoods(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12),
            )),
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  BuildContext mContext;

  Content({Key key, this.mContext}) : super(key: key);
  @override
  _ContentState createState() => _ContentState(mContext: mContext);
}

class _ContentState extends State<Content> {
  BuildContext mContext;

  _ContentState({Key key, this.mContext});

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    getMallGoods(mContext);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsList>(builder: (context, child, data) {
      if (data.goodsList != null && data.goodsList.length > 0) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            // height: ScreenUtil().setHeight(ScreenUtil.getInstance().height - 400),
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText: '上拉加载',
                loadedText: '加载完成',
                loadingText: '加载中',
                loadText: '加载更多',
              ),
              child: GridView.count(
                //一行2列
                crossAxisCount: 2,
                // 左右间隔
                crossAxisSpacing: 10.0,
                // 上下间隔
                mainAxisSpacing: 10.0,
                padding: EdgeInsets.all(5.0),
                childAspectRatio: 2 / 3,
                children: _getGridViewItem(data.goodsList),
              ),
              loadMore: () async {
                print('加载更多...');
                Provide.value<ChildCategory>(context).chagePage(
                    (Provide.value<ChildCategory>(context).page) + 1);
                getMallGoods(context, loadMore: true);
              },
            ),
          ),
        );
      } else {
        return Text('暂无数据');
      }
    });
  }

  List<Widget> _getGridViewItem(List<Goods> data) {
    List<Widget> widgetList = data.map((val) {
      return _contentInkwell(val);
    }).toList();
    return widgetList;
  }

  Widget _contentInkwell(Goods goods) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/detail?id=${goods.goodsId}');
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Image.network(
              goods.image,
            ),
            Container(
              height: ScreenUtil().setHeight(50),
              child:   Text(
              goods.goodsName,
              style: TextStyle(
                color: Colors.pink,
                fontSize: ScreenUtil().setSp(26),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('￥' + goods.presentPrice.toString(),
                        style: TextStyle( fontSize: ScreenUtil().setSp(22),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('￥' + goods.oriPrice.toString(),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: ScreenUtil().setSp(22),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//获取热销商品数据
void getMallGoods(BuildContext context, {bool loadMore}) async {
  List<Goods> mallGoodsList = [];
  var formData = {};
  formData = {
    'categoryId': Provide.value<ChildCategory>(context).categoryId,
    'categorySubId': Provide.value<ChildCategory>(context).categorySubId,
    'page': Provide.value<ChildCategory>(context).page,
  };
  print('getMallGoods:' + formData.toString());
  await request('getMallGoods', formData: formData).then((val) {
    var data = json.decode(val.toString());
    MallGoodsModel goodsList = MallGoodsModel.fromJson(data);
     if (loadMore != null && loadMore) {
      mallGoodsList.addAll(Provide.value<CategoryGoodsList>(context).goodsList);
    }
    // if ((goodsList.data ==null ||goodsList.data.length <= 0 ) && loadMore) {
    //   Fluttertoast.showToast(
    //     msg: '没有更多商品了',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     textColor: Colors.white,
    //     backgroundColor: Colors.pink
    //   );
    //   Provide.value<CategoryGoodsList>(context).getGoodsList(mallGoodsList);
    //   return;
    // }
  
    mallGoodsList.addAll(goodsList.data);
    Provide.value<CategoryGoodsList>(context).getGoodsList(mallGoodsList);
  });
}
