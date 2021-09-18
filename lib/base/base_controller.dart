import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'base_common_widgets.dart';
import 'widget_state.dart';


/// createdby Daewu Bintara
/// Friday, 1/29/21

///
/// --------------------------------------------
/// [Example]
///
/// class HomeController extends BaseController {
///
///   var count = 0.obs;
///
///   @override
///   void onInit() {
///     super.onInit();
///   }
///
///   void increment() => count ++;
///
/// }
///
/// RECOMENDED FOR your [Controller].
/// Please extends to your [Controller].
/// read the [Example] above.
class BaseController extends GetxController
    with BaseCommonWidgets, WidgetState, ScreenState {
  bool isLoadMore = false;
  bool withScrollController = false;
  ScrollController? scrollController;

  set setEnableScrollController(bool value) => withScrollController = value;

  @override
  void onInit() {
    super.onInit();
    if (withScrollController) {
      // logWhenDebug("SCROLL CONTROLLER ENABLE on ${Get.currentRoute}",
      //     withScrollController.toString());
      scrollController = ScrollController();
      scrollController?.addListener(_scrollListener);
    }
  }

  void onRefresh() {}
  
  void onLoadMore() {}

  void _scrollListener() {
    if (scrollController == null) return;
    if (scrollController!.offset >= scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      if(!isLoadMore) {
        isLoadMore = true;
        update();
        onLoadMore();
      }
    }
    _innerBoxScrolled();
  }
  
  void _innerBoxScrolled() {
    if (scrollController == null) return;
    if(scrollController!.offset <= 60 && scrollController!.offset > 40) {
      // if(!innerBoxIsScrolled) {
      //   innerBoxIsScrolled = true;
      //   update();
      // }
    }
    if(scrollController!.offset >= 0 && scrollController!.offset <= 40) {
      // if(innerBoxIsScrolled) {
      //   innerBoxIsScrolled = false;
      //   update();
      // }
    }
  } 

}
