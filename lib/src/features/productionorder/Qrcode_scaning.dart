import 'dart:convert';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/login/login.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/po_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/splashscreen/splashscreen.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/appbtn.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/circular_desing.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/session_manger.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/snackbar.dart';
import 'package:konark_inventory_tracking_flutter_app/src/modal/runningPO_modal.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrcodeScaning extends StatefulWidget {
  final ProductionOrderModal productionOrderData;
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
    if (SessionManager.isSessionExpired()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Splashscreen()),
      );
    }
  }

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  File? _imageFile;
  String? _base64Image;

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        _imageFile = imageFile;
        _base64Image = base64Image;
      });
    }
  }

  Future<void> setUpTheConnection() async {
    if (_base64Image == null || result == null) {
      setSnackbar("Image or QR data missing", context, 2);
      return;
    }

    Map<String, dynamic> data = {
      "production_order_id": widget.productionOrderData.productionOrderId,
      "production_order_item_id":
          widget
              .productionOrderData
              .assemblyLine!
              .lineStage!
              .productionOrderItemId!,
      "assembly_line_id": widget.productionOrderData.assemblyLine!.id,
      "assembly_line_name": widget.productionOrderData.assemblyLine!.name,
      "plant_name": widget.productionOrderData.assemblyLine!.plant!.name,
      "stage_id": widget.productionOrderData.assemblyLine!.lineStage!.id,
      "stage_name": widget.productionOrderData.assemblyLine!.lineStage!.name,
      "qr_data": result!.code,
      "image": _base64Image, // <-- Send base64 string
    };

    try {
      final settings = ConnectionSettings(
        host: "b-204a6cd8-509f-487a-b23b-3d9211f44bbf.mq.ap-south-1.on.aws",
        authProvider: PlainAuthenticator("rabbitmq", "admin1234567890"),
        virtualHost: "/",
        port: 5671,
        connectionName: "Konark_Flutter_app",
        tlsContext: SecurityContext(withTrustedRoots: true),
      );

      final client = Client(settings: settings);
      Channel channel = await client.channel();
      Queue queue = await channel.queue("mobile_object_queue", durable: true);
      String message = jsonEncode(data);

      queue.publish(message);
      print("Message published: $message");

      await client.close();

      setSnackbar("Data sent successfully", context, 0);
      print('you are in the if');
      int retryCount = 0;
      const maxRetries = 7;
      const retryDelay = Duration(seconds: 2);

      while (retryCount < maxRetries) {
        poProvider!.isLoading = true;
        setState(() {});
        await poProvider!
            .getClassification(
              context,
              widget.productionOrderData.productionOrderId.toString(),
              result!.code.toString(),
            )
            .then((value) async {
              poProvider!.isLoading = false;
              setState(() {});
              if (value == 'true') {
              } else if (value == 'false') {
                setSnackbar("Something went wrong", context, 2);
                return;
              } else {
                retryCount++;
                print(retryCount);
                await Future.delayed(retryDelay);
                setSnackbar(value, context, 2);
                return;
              }
            });
      }
    } catch (e, stacktrace) {
      print("Error: $e");
      print("Stacktrace: $stacktrace");
      setSnackbar("Failed to send data", context, 2);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _imageFile != null
                    ? Row(
                      children: [
                        Stack(
                          children: [
                            Image.file(
                              _imageFile!,
                              height: MediaQuery.of(context).size.height * 0.95,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 100,
                              child: AppButton(
                                backgroundColor: Color(0xfff0A53BE),
                                width: MediaQuery.of(context).size.width * 0.5,
                                btnText: 'Submit',
                                voidCallBack: setUpTheConnection,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                    : Expanded(flex: 5, child: _buildQrView(context)),
              ],
            ),
            poProvider!.isLoading
                ? getCircularDesingScreen(context)
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 200.0;

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
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        setState(() {
          result = scanData;
        });

        poProvider!.isLoading = true;

        await poProvider!
            .scanQrCode(
              context,
              scanData.code.toString(),
              widget.productionOrderData,
            )
            .then((value) async {
              if (value == 'true') {
                await _openCamera();
              } else if (value == 'false') {
                setSnackbar("Something went wrong", context, 2);
                return;
              } else {
                setSnackbar(value, context, 2);
                return;
              }

              poProvider!.isLoading = false;
            });
      }
    });
  }
}
