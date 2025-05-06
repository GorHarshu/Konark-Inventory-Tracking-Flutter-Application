import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/Qrcode_scaning.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/appbtn.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/genrateTxt.dart';
import 'package:konark_inventory_tracking_flutter_app/src/modal/runningPO_modal.dart';

class ProductionOrder extends StatefulWidget {
  ProductionOrderModal productionOrderData;
  ProductionOrder({super.key, required this.productionOrderData});

  @override
  State<ProductionOrder> createState() => _ProductionOrderState();
}

class _ProductionOrderState extends State<ProductionOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CMNTextInter(
              text: 'Station \nOperation Interface',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppButton(
              borderRadius: 12,
              btnText: 'Scan Product',
              boldfont: FontWeight.bold,
              backgroundColor: Color(0xfff0A53BE),
              voidCallBack: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => QrcodeScaning(
                          productionOrderData: widget.productionOrderData,
                        ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CMNTextInter(
              text: 'Product Data',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          getCMNDesignWidget(
            "Order No : ",
            widget.productionOrderData.productionOrderId!,
          ),
        ],
      ),
    );
  }

  getCMNDesignWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Image.asset('assets/icon.png'),
          CMNTextInter(text: title, fontSize: 14, fontWeight: FontWeight.w700),
          CMNTextInter(text: value),
        ],
      ),
    );
  }
}
