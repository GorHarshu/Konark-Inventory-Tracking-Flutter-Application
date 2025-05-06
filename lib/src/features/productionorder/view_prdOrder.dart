import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/Image_Capture.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/appbtn.dart';

class ProductionOrder extends StatefulWidget {
  const ProductionOrder({super.key});

  @override
  State<ProductionOrder> createState() => _ProductionOrderState();
}

class _ProductionOrderState extends State<ProductionOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppButton(
              btnText: 'Scan Product',
              boldfont: FontWeight.bold,
              backgroundColor: Color(0xfff0A53BE),
              voidCallBack: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraExample()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
