import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/colors.dart';

getCircularDesingScreen(BuildContext context) {
  return InkWell(
    onTap: () {
      print('testing');
    },
    child: Container(
      color: Colors.grey.withOpacity(0.5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: ColorsRes.white),
            SizedBox(height: 10),
            Text('Loading...', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    ),
  );
}
