import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/colors.dart';

// Variable for network checking
bool isNetworkAvailable = true;
bool isInternalServerError = false;

Future<bool> checkIsNetworkAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();

  return !connectivityResult.contains(ConnectivityResult.none);
}

Widget noInternet(BuildContext context, VoidCallback? setStateNoInternet) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.8,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        noInternetImage(context),
        noInternetText(context),
        noInternetDescription(context),
        tryAgainButton(context, setStateNoInternet),
      ],
    ),
  );
}

Widget noInternetImage(BuildContext context) {
  return Icon(Icons.wifi_off, size: 100, color: Colors.grey[400]);
}

Widget noInternetText(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 32.0),
    child: Text(
      'No Internet',
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget noInternetDescription(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
    child: Text(
      'Connection Error: No Available Networks Found',
      textAlign: TextAlign.center,
      style: GoogleFonts.lato(
        fontSize: 20,
        color: Colors.grey[400],
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget tryAgainButton(BuildContext context, VoidCallback? onBtnSelected) {
  return CupertinoButton(
    child: Container(
      width: 110,
      height: 45,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: ColorsRes.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        'Try Again',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    onPressed: () {
      if (onBtnSelected != null) {
        onBtnSelected();
      }
    },
  );
}
