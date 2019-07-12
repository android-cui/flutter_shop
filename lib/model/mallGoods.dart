class MallGoodsModel {
  String code;
  String message;
  List<Goods> data;

  MallGoodsModel({this.code, this.message, this.data});

  MallGoodsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Goods>();
      json['data'].forEach((v) {
        data.add(new Goods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Goods {
  num oriPrice; //商品的Id，用于进入商品页时，查询商品详情。
  String image; //商品名称
  String goodsId; //商品的图片
  num presentPrice; //市场价格（贵的价格）
  String goodsName; //商城价格(便宜的价格)

  Goods(
      {this.oriPrice,
      this.image,
      this.goodsId,
      this.presentPrice,
      this.goodsName});

  Goods.fromJson(Map<String, dynamic> json) {
    oriPrice = json['oriPrice'];
    image = json['image'];
    goodsId = json['goodsId'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oriPrice'] = this.oriPrice;
    data['image'] = this.image;
    data['goodsId'] = this.goodsId;
    data['presentPrice'] = this.presentPrice;
    data['goodsName'] = this.goodsName;
    return data;
  }
}
