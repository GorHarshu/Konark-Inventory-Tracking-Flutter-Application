import 'dart:convert' show jsonDecode;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/api.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/snackbar.dart';
import 'package:konark_inventory_tracking_flutter_app/src/modal/dashcount_modal.dart';
import 'package:konark_inventory_tracking_flutter_app/src/modal/runningPO_modal.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;

  DashboardCountModal? countList;

  Future<void> getDashBoardCount(BuildContext context) async {
    var url = Uri.parse('$finalUrl/dashboard');
    print('URL  : $url');
    var response = await get(url, headers: Auth.commonHeader);
    print('Auth.commonHeader : ${Auth.commonHeader}');
    var data = jsonDecode(response.body.toString());
    print('data : $data');
    print('response : ${response.body.toString()}');
    print('statusCode : ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        countList = DashboardCountModal.fromJson(data);
      } else {
        setSnackbar(data['detail'], context, 2);
      }
    } catch (e) {
      setSnackbar('Something went wrong', context, 2);
    }
  }

  List<ProductionOrderModal> runningAssemblyLinesList = [];

  Future<void> getRunningPO(BuildContext context) async {
    var url = Uri.parse('$finalUrl/mobile_users/${Auth.userID}');
    print('URL  : $url');
    var response = await get(url, headers: Auth.commonHeader);
    print('Auth.commonHeader : ${Auth.commonHeader}');
    var data = jsonDecode(response.body.toString());
    print('data : $data');
    print('response : ${response.body.toString()}');
    print('statusCode : ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        runningAssemblyLinesList =
            (data as List)
                .map((e) => ProductionOrderModal.fromJson(e))
                .toList();
      } else {
        setSnackbar(data['detail'], context, 2);
      }
    } catch (e) {
      setSnackbar('Something went wrong', context, 2);
    }
  }
}
