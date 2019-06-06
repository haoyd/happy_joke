import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';

class HudUtil {

  ProgressHUD hud;
  bool isShowing;

  HudUtil() {
    hud = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Color(0x50000000),
      borderRadius: 5.0,
      text: '加载中...',
    );
  }

  show() {
    hud.state.show();
    isShowing = true;
  }

  hide() {
    hud.state.dismiss();
    isShowing = false;
  }

}