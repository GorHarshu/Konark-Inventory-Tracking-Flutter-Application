import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/homepage/home_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/login/login_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/po_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/splashscreen/splashscreen.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/connectivity.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/hive_localstorage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter<User>(UserAdapter());
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfromationInternet();
  }

  getInfromationInternet() async {
    isNetworkAvailable = await checkIsNetworkAvailable();
    setState(() {});
  }

  setStateNoInternet() {
    getInfromationInternet();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<PoProvider>(create: (context) => PoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Splashscreen()),
      ),
    );
  }
}
