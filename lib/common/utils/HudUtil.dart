import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';

class HudUtil {

  ProgressHUD hud;
  bool _isLoading = true;

  HudUtil() {
    hud = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: Color(0x80000000),
      borderRadius: 5.0,
      text: '加载中...',
    );
  }

  show() {
    if (_isLoading) {
      return;
    }
    hud.state.show();
    _isLoading = true;
  }

  hide() {
    if (!_isLoading) {
      return;
    }
    hud.state.dismiss();
    _isLoading = false;
  }
  
  bool isLoading() {
    return _isLoading;
  }

}