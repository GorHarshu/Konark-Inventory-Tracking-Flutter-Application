import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/api.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/snackbar.dart';
import 'package:konark_inventory_tracking_flutter_app/src/modal/runningPO_modal.dart';
import 'package:konark_inventory_tracking_flutter_app/src/modal/sprate_po_modal.dart';

class PoProvider extends ChangeNotifier {
  bool isLoading = false;

  SeprateProductionOrderModal? SpecificPOdata;

  Future<void> getSpecficPO(BuildContext context, String poID) async {
    var url = Uri.parse('$finalUrl/mobile_users_production_order/${poID}');
    print('URL  : $url');
    var response = await get(url, headers: Auth.commonHeader);
    print('Auth.commonHeader : ${Auth.commonHeader}');
    var data = jsonDecode(response.body.toString());
    print('data : $data');
    print('response : ${response.body.toString()}');
    print('statusCode : ${response.statusCode}');

    try {
      if (response.statusCode == 200) {
        SpecificPOdata = SeprateProductionOrderModal.fromJson(data);
      } else {
        setSnackbar(data['detail'], context, 2);
      }
    } catch (e) {
      setSnackbar('Something went wrong', context, 2);
    }
  }

  Future<String> scanQrCode(
    BuildContext context,
    String qrcode,
    ProductionOrderModal productionOrderData,
  ) async {
    Map bodyParms = {
      "qr_code": qrcode,
      "sales_order_item_id":
          productionOrderData.salesOrderItemId == null
              ? ""
              : productionOrderData.salesOrderItemId,
      "is_dispatch":
          productionOrderData.isDispatch == null
              ? true
              : productionOrderData.isDispatch,
      "production_order_id": productionOrderData.productionOrderId,
      "mapping_status": productionOrderData.mappingStatus,
      "assembly_line": {
        "id": productionOrderData.assemblyLine!.id,
        "name": productionOrderData.assemblyLine!.name,
        "plant": {
          "id": productionOrderData.assemblyLine!.plant!.id,
          "name": productionOrderData.assemblyLine!.plant!.name,
          "code": productionOrderData.assemblyLine!.plant!.code,
        },
        "line_stage": {
          "id": productionOrderData.assemblyLine!.lineStage!.id,
          "name": productionOrderData.assemblyLine!.lineStage!.name,
          "is_object_detection":
              productionOrderData.assemblyLine!.lineStage!.isObjectDetection,
          "is_rejected_item_qr":
              productionOrderData.assemblyLine!.lineStage!.isRejectedItemQr,
          "production_order_item_id":
              productionOrderData
                  .assemblyLine!
                  .lineStage!
                  .productionOrderItemId,
        },
      },
    };
    print('bodyParms: $bodyParms');

    try {
      var response = await post(
        Uri.parse('$finalUrl/mobile_users'),
        headers: Auth.commonHeader,
        body: json.encode(bodyParms),
      );

      var data = jsonDecode(response.body.toString());

      print('response: ${response.statusCode}');
      print('response: ${response.body.toString()}');

      print('data: $data');

      if (response.statusCode == 200) {
        if (data['error'] == "Incorrect QR") {
          setSnackbar(data['error'], context, 2);
          return 'false';
        } else {
          setSnackbar(data['message'], context, 0);
          return 'true';
        }
      } else {
        print('else executed');
        if (response.statusCode != 200) {
          print('second if executed');
          return data['detail'].toString();
        } else {
          print('second else executed');
          return 'false';
        }
      }
    } catch (e) {
      print('catch executed');
      setSnackbar(e.toString(), context, 2);
      return 'false';
    }
  }

  Future<String> getClassification(
    BuildContext context,
    String qrcode,
    String id,
  ) async {
    try {
      var response = await get(
        Uri.parse(
          '$finalUrl/mobile_users_production_order/classification_result?production_order_id=$id&qr_code=$qrcode',
        ),
        headers: Auth.commonHeader,
      );

      print(
        'url ${'$finalUrl/mobile_users_production_order/classification_result?production_order_id=$id&qr_code=$qrcode'}',
      );
      print('response: ${response.statusCode}');
      print('response: ${response.body.toString()}');
      var data = jsonDecode(response.body.toString());

      print('data: $data');

      if (response.statusCode == 200) {
        return 'true';
      } else {
        print('else executed');
        if (response.statusCode != 200) {
          print('second if executed');
          return data['detail'].toString();
        } else {
          print('second else executed');
          return 'false';
        }
      }
    } catch (e) {
      print('catch executed ${e.toString()}');
      setSnackbar(e.toString(), context, 2);
      return 'false';
    }
  }
}
