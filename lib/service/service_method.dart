import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/constants/service_url.dart';

//获取首页主题内容
Future request(url, {formData}) async {
  try {
    print('开始获取数据。。。。。');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formData != null) {
      response = await dio.post(servicePath[url], data: formData);
    } else {
      response = await dio.post(servicePath[url]);
    }
    print(url + ':' + response.data);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口抛出异常');
    }
  } catch (e) {
    return print('Error: ==========>${e}');
  }
}
