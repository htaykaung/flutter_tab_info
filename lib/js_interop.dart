import 'dart:convert';
import 'dart:js_interop';

import 'package:get_tab_info/tabinfo.dart';

import 'raw_interop.dart' as interop;

abstract class JsInterop {
  static Future<TabInfoModel?> getTabInfo() async {
    final resp = (await interop.getTabInfo().toDart).toDart;
    try {
      return TabInfoModel.fromJson(jsonDecode(resp));
    } catch (e) {
      // DO NOTHING
    }
    return null;
  }

  static Future<List<TabInfoModel>?> getAllTabInfo() async {
    final resp = (await interop.getAllTabInfo().toDart).toDart;
    try {
      List<TabInfoModel> l = [];
      for (var e in jsonDecode(resp)) {
        l.add(TabInfoModel.fromJson(e));
      }
      return l;
    } catch (e) {
      // DO NOTHING
    }
    return null;
  }
}
