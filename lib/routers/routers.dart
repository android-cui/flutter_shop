import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../routers/router_handler.dart';

class Routers {
  static String root ='/';
  static String detailsPages = '/detail';

  static void configRouters(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> map){
        print('ERROR======>RUTE WAS  NOT FOUND');
      }
    );

    router.define(detailsPages,handler: detailsHandler1);
    
  }
}