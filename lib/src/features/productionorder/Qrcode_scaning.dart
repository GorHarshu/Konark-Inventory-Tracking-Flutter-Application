import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/Image_Capture.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/po_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/snackbar.dart';
import 'package:konark_inventory_tracking_flutter_app/src/modal/runningPO_modal.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrcodeScaning extends StatefulWidget {
  ProductionOrderModal productionOrderData;
  QrcodeScaning({super.key, required this.productionOrderData});

  @override
  State<QrcodeScaning> createState() => _QrcodeScaningState();
}

PoProvider? poProvider;

class _QrcodeScaningState extends State<QrcodeScaning> {
  @override
  void initState() {
    super.initState();
    poProvider = Provider.of<PoProvider>(context, listen: false);
  }

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Expanded(flex: 5, child: _buildQrView(context))]),
      // 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 ||
                MediaQuery.of(context).size.height < 400)
            ? 150.0
            : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        setState(() {
          result = scanData;
        });

        poProvider!.isLoading = true;
        setState(() {});

        await poProvider!
            .scanQrCode(
              context,
              scanData.code.toString(),
              widget.productionOrderData,
            )
            .then((value) {
              print('valuedata $value');

              // Handle the result
              if (value == 'true') {
                print('you are here ');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraExample()),
                );
              } else if (value == 'false') {
                setSnackbar("Something went wrong", context, 2);
              } else {
                setSnackbar(value, context, 2);
              }
            });
      }
    });
  }
}
