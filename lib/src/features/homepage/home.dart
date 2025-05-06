import 'package:flutter/material.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/homepage/home_provider.dart';
import 'package:konark_inventory_tracking_flutter_app/src/features/productionorder/view_prdOrder.dart';
import 'package:konark_inventory_tracking_flutter_app/src/helper/genrateTxt.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

HomeProvider? homeProvider;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    getData();
  }

  getData() async {
    homeProvider!.isLoading = true;
    setState(() {});
    await homeProvider!.getDashBoardCount(context);
    await homeProvider!.getRunningPO(context);
    homeProvider!.isLoading = false;
    setState(() {});
  }

  final List<String> timeIntervals = [
    '1 min',
    '2 min',
    '5 min',
    '10 min',
    '30 min',
  ];
  String? selectedInterval = '5 min';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [IconButton(icon: const Icon(Icons.person), onPressed: () {})],
      ),
      body:
          homeProvider!.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: CMNTextInter(
                              text: "Dashboard",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              CMNTextInter(text: 'Refresh Interval'),
                              SizedBox(width: 10),
                              Container(
                                width: 130,
                                child: DropdownButtonFormField<String>(
                                  value: selectedInterval,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  items:
                                      timeIntervals.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedInterval = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GetCMNDesignWidget(
                          'Finish Products',
                          homeProvider!.countList!.finishProduct!.toString(),
                          Color(0xfffA05CC0).withOpacity(0.2),
                          "assets/finishprd.png",
                        ),
                        SizedBox(width: 10),
                        GetCMNDesignWidget(
                          'Total Available \nAssembly Line',
                          homeProvider!.countList!.availableAssemblyLines!
                              .toString(),
                          Color(0xfff5DE0BB).withOpacity(0.2),
                          "assets/totalavialbleline.png",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GetCMNDesignWidget(
                          'Sales Orders',
                          homeProvider!.countList!.openSalesOrder!.toString(),
                          Color(0xfff5AB6E4).withOpacity(0.2),
                          "assets/salesorder.png",
                        ),
                        SizedBox(width: 30),
                        GetCMNDesignWidget(
                          'Running Assembly \nline',
                          homeProvider!.countList!.assemblyLinesInRunning!
                              .toString(),
                          Color(0xfffA05CC0).withOpacity(0.2),
                          "assets/runningassembleyline.png",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GetCMNDesignWidget(
                          'Dispatched Sales\nOrder',
                          homeProvider!.countList!.disptachedSalesOrder!
                              .toString(),
                          Color(0xfff77AA79).withOpacity(0.2),
                          "assets/dispatchso.png",
                        ),
                        GetCMNDesignWidget(
                          'Assembly \nline in Queue',
                          homeProvider!.countList!.assemblyLineInQueue!
                              .toString(),
                          Color(0xfffFF8989).withOpacity(0.2),
                          "assets/queassemblyline.png",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GetCMNDesignWidget(
                          'Production Orders',
                          homeProvider!.countList!.openProductionOrders!
                              .toString(),
                          Color(0xfff5DE0BB).withOpacity(0.2),
                          "assets/productionorder.png",
                        ),
                        GetCMNDesignWidget(
                          'Available \nAssembly line',
                          homeProvider!.countList!.availableAssemblyLines!
                              .toString(),
                          Color(0xfff0083FF).withOpacity(0.2),
                          "assets/avilableassemblylines.png",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GetCMNDesignWidget(
                          'Partial Confirmed\nProduction Orders',
                          homeProvider!
                              .countList!
                              .partiallyConfirmedProductionOrders!
                              .toString(),
                          Color(0xfff8CDD7C).withOpacity(0.2),
                          "assets/partialorder.png",
                        ),
                        GetCMNDesignWidget(
                          'SKU Scanned by\nPortal',
                          homeProvider!.countList!.skuScannedByPortal!
                              .toString(),
                          Color(0xfffED6C02).withOpacity(0.2),
                          "assets/skuportal.png",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GetCMNDesignWidget(
                          'Completed \nConfirmed \nProduction Orders',
                          homeProvider!
                              .countList!
                              .completedConfirmedProductionOrders!
                              .toString(),
                          Color(0xfff1976D2).withOpacity(0.2),
                          "assets/complettedorder.png",
                        ),
                        GetCMNDesignWidget(
                          'Final goods \nScanned by \nPortal',
                          homeProvider!.countList!.finalGoodScannedByPortal!
                              .toString(),
                          Color(0xfffFF8989).withOpacity(0.2),
                          "assets/finalGoods.png",
                        ),
                      ],
                    ),

                    Divider(color: Colors.blue.withOpacity(0.3)),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CMNTextInter(
                        text: "Production Order",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 10,
                        columns: [
                          DataColumn(
                            label: CMNTextInter(
                              text: 'Sr No',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DataColumn(
                            label: CMNTextInter(
                              text: 'Running Assembly Line',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DataColumn(
                            label: CMNTextInter(
                              text: 'Plant',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DataColumn(
                            label: CMNTextInter(
                              text: 'Production Order No.',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DataColumn(
                            label: CMNTextInter(
                              text: 'Completed',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DataColumn(
                            label: CMNTextInter(
                              text: 'Pending',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          DataColumn(
                            label: CMNTextInter(
                              text: 'Error',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                        rows: List.generate(
                          homeProvider!.runningAssemblyLinesList.length,
                          (i) => DataRow(
                            cells: [
                              DataCell(
                                Center(
                                  child: CMNTextInter(
                                    text: (i + 1).toString(),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              DataCell(
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProductionOrder(
                                              productionOrderData:
                                                  homeProvider!
                                                      .runningAssemblyLinesList[i],
                                            ),
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: CMNTextInter(
                                      text:
                                          homeProvider!
                                              .runningAssemblyLinesList[i]
                                              .assemblyLine!
                                              .name
                                              .toString(),
                                      fontSize: 14,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CMNTextInter(
                                    text:
                                        homeProvider!
                                                    .runningAssemblyLinesList[i]
                                                    .assemblyLine!
                                                    .plant!
                                                    .code !=
                                                null
                                            ? homeProvider!
                                                .runningAssemblyLinesList[i]
                                                .assemblyLine!
                                                .plant!
                                                .code
                                                .toString()
                                            : " - ",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CMNTextInter(
                                    text: '',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CMNTextInter(
                                    text: '',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CMNTextInter(
                                    text: '',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: CMNTextInter(
                                    text: '',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
    );
  }

  GetCMNDesignWidget(String title, String value, Color color, String imgFile) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(imgFile, height: 50, width: 50),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CMNTextInter(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              CMNTextInter(
                text: value,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
