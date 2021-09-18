import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseLoadingDialog {
  static bool debug = true;
  static List<LoadingData> loadInfo = [];
  static int currentSession = 0;
  static void showLoadingDialog(String name) {
    if (debug) {
      print('----- Show loading: $name');
    }
    bool showDialog = false;
    if (loadInfo.isEmpty) {
      // Show dialog
      currentSession = DateTime
          .now()
          .millisecondsSinceEpoch;
      showDialog = true;
    }
    final LoadingData data = LoadingData(name, currentSession);
    loadInfo.add(data);
    Future.delayed(Duration.zero, () {
      if (showDialog && loadInfo.contains(data)) {
        // show dialog
        Get.dialog(const Center(child: CircularProgressIndicator()),
            barrierDismissible: false).then((value) {
          if (debug) {
            print('----- Close Dialog: $name');
          }
          _removeSessionData(data.session);
          printDebugInfo();
        });
      }
      printDebugInfo();
    });
    EasyDebounce.debounce(
        'BaseLoadingDialog',                 // <-- An ID for this particular debouncer
        const Duration(milliseconds: 61000),    // <-- The debounce duration
            () => closeIfTimeout()                // <-- The target method
    );
  }

  static void printDebugInfo(){
    if (debug) {
      print('-------Loading Dialog: size ${loadInfo.length}------');
      final time = DateTime.now().millisecondsSinceEpoch;
      for (var value in loadInfo) {
        print('-- Loading name: ${value.name} sec: ${(time - value.start)/1000}');
      }
      print('------- End');
    }
  }

  static void closeLoadingDialog(String name) {
    if (debug) {
      print('----- Close loading: $name');
    }
    final bool nameExist = loadInfo.any((element) => element.name == name);
    if (!nameExist) return;
    loadInfo.removeWhere((element) => element.name == name);
    printDebugInfo();
    if (loadInfo.isEmpty) {
      Get.back();
    }
  }

  static void _removeSessionData(int session) {
    print('Remove Dialog Session $session');
    loadInfo.removeWhere((element) => element.session == session);
  }

  static void closeIfTimeout(){
    if (loadInfo.isEmpty) return;
    final time = DateTime.now().millisecondsSinceEpoch;
    final isTimeout = loadInfo.any((element) => time - element.start > 60000);
    if (!isTimeout) return;
    loadInfo.removeWhere((element) => time - element.start > 60000);
    if (loadInfo.isEmpty) {
      Get.back();
    }
  }
}

class LoadingData {
  final String name;
  final int session;
  final int start = DateTime.now().millisecondsSinceEpoch;
  int currentSession = 0;

  LoadingData(this.name, this.session);
}
