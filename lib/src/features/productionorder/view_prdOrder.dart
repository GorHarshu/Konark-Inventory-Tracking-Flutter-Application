import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/Qrcode_scaning.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/po_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/splashscreen/splashscreen.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/appbtn.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/genrateTxt.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/session_manger.dart';
import 'package:konark_inventory_tracking_flutter_app/src/modal/runningPO_modal.dart';
import 'package:provider/provider.dart';

class ProductionOrder extends StatefulWidget {
  ProductionOrderModal productionOrderData;
  ProductionOrder({super.key, required this.productionOrderData});

  @override
  State<ProductionOrder> createState() => _ProductionOrderState();
}

PoProvider? poProvider;

class _ProductionOrderState extends State<ProductionOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    poProvider = Provider.of<PoProvider>(context, listen: false);
    getData();
  }

  getData() async {
    if (SessionManager.isSessionExpired()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Splashscreen()),
      );
    }
    poProvider!.isLoading = true;
    setState(() {});
    await poProvider!.getSpecficPO(
      context,
      widget.productionOrderData.productionOrderId.toString(),
    );

    poProvider!.isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          poProvider!.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
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

                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CMNTextInter(
                      text: 'Product Data',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  getCMNDesignWidget(
                    "Order No : ",
                    poProvider!.SpecificPOdata!.id!,
                  ),
                  SizedBox(height: 5),
                  getCMNDesignWidget(
                    "Material No : ",
                    poProvider!.SpecificPOdata!.materialId!,
                  ),
                  SizedBox(height: 5),
                  getCMNDesignWidget(
                    "Material: ",
                    poProvider!.SpecificPOdata!.material!.name!,
                  ),
                  SizedBox(height: 5),
                  getCMNDesignWidget(
                    "Current Po: ",
                    poProvider!.SpecificPOdata!.orderNumber!,
                  ),
                  SizedBox(height: 5),
                  getCMNDesignWidget(
                    "Quantity: ",
                    poProvider!.SpecificPOdata!.quantity!.toString(),
                  ),
                  SizedBox(height: 5),
                  getCMNDesignWidget(
                    "Plant: ",
                    poProvider!.SpecificPOdata!.plantId!.toString(),
                  ),
                  SizedBox(height: 5),
                  getCMNDesignWidget(
                    "Storage Location: ",
                    poProvider!.SpecificPOdata!.storageLocation!.toString(),
                  ),
                  SizedBox(height: 5),
                  getCMNDesignWidget(
                    "Batch: ",
                    poProvider!.SpecificPOdata!.batch!.toString(),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppButton(
                      borderRadius: 12,
                      btnText: 'Scan Product',
                      boldfont: FontWeight.bold,
                      backgroundColor: Color(0xfff0A53BE),
                      voidCallBack: () {
                        if (SessionManager.isSessionExpired()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Splashscreen(),
                            ),
                          );
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => QrcodeScaning(
                                  productionOrderData:
                                      widget.productionOrderData,
                                ),
                          ),
                        );
                      },
                    ),
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
          SizedBox(width: 4),
          CMNTextInter(text: title, fontSize: 12, fontWeight: FontWeight.w700),
          CMNTextInter(text: value, fontSize: 12, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}
