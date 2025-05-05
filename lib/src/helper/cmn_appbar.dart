import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/cmn_text_widget.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/colors.dart';

cmnAppbar(String text, {List<Widget>? actions}) {
  return AppBar(
    iconTheme: IconThemeData(color: ColorsRes.white),
    backgroundColor: ColorsRes.primaryColor,
    title: CmnText(
      text: text,
      color: ColorsRes.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    actions: actions,
  );
}
