import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/fonts.dart';
import '../../../constants/spaces.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(),
      body: SizerUtil.deviceType == DeviceType.web
          ? Row(
              children: [
                buildExpandedSidebar(),
                buildExpandedBody(),
              ],
            )
          : buildExpandedBody(),
    );
  }

  Expanded buildExpandedBody() {
    return Expanded(
      flex: 5,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTopContainer('Rides in progress ', '7', Colors.orange),
                buildTopContainer('Package Deliver', '17', Colors.green),
                buildTopContainer('Cancel Deliver ', '4', Colors.red),
                buildTopContainer('Schedule Delivery ', '7', Colors.yellow),
              ],
            ),
            buildRevenueChartContainer(),
            Spaces.y2,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurStyle: BlurStyle.outer,
                          offset: Offset(-1, 1),
                          blurRadius: 0.1),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  height: 110,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Location')),
                      DataColumn(label: Text('Rating')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('Santos Enoque')),
                        DataCell(Text('New York City')),
                        DataCell(Text('★4.0')),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.delivery_dining),
                            onPressed: () {
                              // Handle assign delivery button click
                            },
                          ),
                        ),
                      ]),
                      // ... more rows for other drivers
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildRevenueChartContainer() {
    final data = [
      SalesData('Today', 23),
      SalesData('Yesterday', 150),
      SalesData('2 days', 80),
      SalesData('24 Jun', 60),
      SalesData('23 Jun', 120),
      SalesData('22 Jun', 50),
      SalesData('21 Jun', 90),
    ];

    final series = [
      charts.Series<SalesData, String>(
        id: 'Revenue chart',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SalesData sales, _) => sales.day,
        measureFn: (SalesData sales, _) => sales.revenue,
        data: data,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        height: 280,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurStyle: BlurStyle.outer,
                offset: Offset(-1, 1),
                blurRadius: 0.1),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Revenue Chart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: charts.BarChart(
                      series,
                      animate: false,
                      barGroupingType: charts.BarGroupingType.stacked,
                      behaviors: [
                        charts.SeriesLegend(
                          position: charts.BehaviorPosition.bottom,
                        ),
                      ],
                      domainAxis: const charts.OrdinalAxisSpec(),
                    ),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: SizedBox(
                      width: 100,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildChartRightContainerData(
                                  'Today Revenue', '7'),
                              Spaces.x3,
                              buildChartRightContainerData('Last 7 days', '3'),
                            ],
                          ),
                          Spaces.y2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildChartRightContainerData(
                                  'Last 30 days', '10'),
                              Spaces.x3,
                              buildChartRightContainerData(
                                  'Last 12 months', '30'),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Center buildChartRightContainerData(String text, String value) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 3.sp,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 6.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildTopContainer(String text, String number, Color color) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 18.h,
        width: 20.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: color, width: 5)),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              Text(
                number,
                style: const TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Visibility buildExpandedSidebar() {
    return Visibility(
      visible: SizerUtil.deviceType == DeviceType.web,
      child: Expanded(
        child: Drawer(
          surfaceTintColor: Colors.white,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                leading: Icon(Icons.auto_graph),
                title: Text(' Overview '),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.person),
                title: Text(' My Profile '),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.car_crash),
                title: Text(' Driver '),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.person_add_alt_outlined),
                title: Text('Client '),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.logout_sharp),
                title: Text(' logout '),
                onTap: null,
              ),
              Spaces.y10,
              Spaces.y5,
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide.none),
                ),
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(BorderSide.none),
                    color: Colors.transparent,
                  ),
                  accountName: Text(
                    "M.Ismail",
                    style: CustomFontStyle.med,
                  ),
                  accountEmail: Text(
                    "muhammad.ismail15604@gmail.com",
                    style: CustomFontStyle.normal,
                  ),
                  currentAccountPictureSize: Size.square(10.sp),
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      "MI",
                      style: TextStyle(fontSize: 5.sp, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Dashboard'),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Image.asset('assets/logo.png'),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notification_add_sharp)),
              SizedBox(height: 3.h, child: const VerticalDivider()),
              const Text("Muhammad Ismail"),
              CircleAvatar(
                child: Text(
                  "MI",
                  style: TextStyle(fontSize: 3.sp, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SalesData {
  final String day;
  final int revenue;

  SalesData(this.day, this.revenue);
}