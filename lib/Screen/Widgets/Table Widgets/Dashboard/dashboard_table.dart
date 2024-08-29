// ignore_for_file: use_super_parameters

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:salespro_saas_admin/Screen/Widgets/Constant%20Data/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../model/seller_info_model.dart';

//Top Selling Store
class TopSellingStore extends StatelessWidget {
  const TopSellingStore({Key? key, required this.todayReg}) : super(key: key);
  final List<SellerInfoModel> todayReg;

  @override
  Widget build(BuildContext context) {
    List<SellerInfoModel> lastFive = todayReg.reversed.take(5).toList();
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 10,
            leading: Icon(
              MdiIcons.bank,
              color: kGreyTextColor,
            ),
            title: Text(
              'New Registered User',
              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: List.generate(
                800 ~/ 5,
                (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 1,
                      ),
                    )),
          ),
          Expanded(
            child: lastFive.isNotEmpty ?? true
                ? ListView.builder(
                    itemCount: lastFive.length < 5 ? lastFive.length : 5,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(bottom: 15),
                        horizontalTitleGap: 10,
                        leading: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(color: kBlueTextColor, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              lastFive[i].companyName?.toString()?.substring(0, 2) ?? '',
                              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        title: Text(
                          lastFive[i].companyName.toString(),
                          style: kTextStyle.copyWith(color: kTitleColor, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          lastFive[i].subscriptionDate.toString().substring(0, 10),
                          style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 16),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('List is empty')),
          ),
        ],
      ),
    );
  }
}

//Lifetime Subscribed
class YearlySubscribed extends StatelessWidget {
  const YearlySubscribed({Key? key, required this.lifeTimeSeller}) : super(key: key);
  final List<SellerInfoModel> lifeTimeSeller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 10,
            leading: const Icon(
              IconlyLight.user3,
              color: kGreyTextColor,
            ),
            title: Text(
              'Yearly Subscribed',
              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: List.generate(
                800 ~/ 5,
                (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 1,
                      ),
                    )),
          ),
          Expanded(
            child: lifeTimeSeller.isNotEmpty ?? true
                ? ListView.builder(
                    itemCount: lifeTimeSeller.length < 5 ? lifeTimeSeller.length : 5,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      return ListTile(
                        contentPadding: EdgeInsets.only(bottom: 15),
                        horizontalTitleGap: 20,
                        leading: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              lifeTimeSeller[i].companyName?.toString()?.substring(0, 2) ?? '',
                              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        title: Text(
                          lifeTimeSeller[i].companyName.toString(),
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        trailing: Text(
                          lifeTimeSeller[i].subscriptionDate.toString().substring(0, 10),
                          style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 16),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('List is empty')),
          ),
        ],
      ),
    );
  }
}

//Expired Shop
class ExpiredShop extends StatelessWidget {
  const ExpiredShop({Key? key, required this.expiredShop}) : super(key: key);
  final List<SellerInfoModel> expiredShop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 10,
            leading: Icon(
              MdiIcons.clockAlertOutline,
              color: kGreyTextColor,
            ),
            title: Text(
              'Expired Shop',
              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              'Package',
              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold,fontSize: 14),
            ),
          ),
          Row(
            children: List.generate(
                800 ~/ 5,
                (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 1,
                      ),
                    )),
          ),
          Expanded(
            child: expiredShop.isNotEmpty ?? true
                ? ListView.builder(
                    itemCount: expiredShop.length < 5 ? expiredShop.length : 5,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(bottom: 15),
                        horizontalTitleGap: 10,
                        leading: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(color: Color(0xFFFF6383), shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              expiredShop[i].companyName?.toString()?.substring(0, 2) ?? '',
                              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        title: Text(
                          expiredShop[i].companyName.toString(),
                          style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        trailing: Text(
                          expiredShop[i].subscriptionDate.toString().substring(0, 10),
                          style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 16.0),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('List is empty'),
                  ),
          ),
        ],
      ),
    );
  }
}

class NewRegisteredUser extends StatefulWidget {
  const NewRegisteredUser({Key? key, required this.allDay, required this.totalSubscribers, required this.allMonthData}) : super(key: key);

  final List<int> allDay;
  final String totalSubscribers;
  final List<double> allMonthData;

  @override
  State<NewRegisteredUser> createState() => _NewRegisteredUserState();
}

class _NewRegisteredUserState extends State<NewRegisteredUser> {
  late List<RegData> dailyData;



  List<MonthlyReg> data = [
    MonthlyReg('Jan', 0),
    MonthlyReg('Feb', 0),
    MonthlyReg('Mar', 0),
    MonthlyReg('Apr', 0),
    MonthlyReg('May', 0),
    MonthlyReg('Jun', 0),
    MonthlyReg('July', 0),
    MonthlyReg('Aug', 0),
    MonthlyReg('Sep', 0),
    MonthlyReg('Oct', 0),
    MonthlyReg('Nov', 0),
    MonthlyReg('Dec', 0),
  ];


  List<String> monthList = [
    'This Month',
    'Yearly',
  ];

  String selectedMonth = 'This Month';

  DropdownButton<String> getCategories() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in monthList) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(
          des,
          style: const TextStyle(color: kTitleColor, fontWeight: FontWeight.normal, fontSize: 14),
        ),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(Icons.keyboard_arrow_down),
      padding: EdgeInsets.zero,
      items: dropDownItems,
      value: selectedMonth,
      onChanged: (value) {
        setState(() {
          selectedMonth = value!;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    data = [
      MonthlyReg('Jan', widget.allMonthData[0]),
      MonthlyReg('Feb', widget.allMonthData[1]),
      MonthlyReg('Mar', widget.allMonthData[2]),
      MonthlyReg('Apr', widget.allMonthData[3]),
      MonthlyReg('May', widget.allMonthData[4]),
      MonthlyReg('Jun', widget.allMonthData[5]),
      MonthlyReg('Jul', widget.allMonthData[6]),
      MonthlyReg('Aug', widget.allMonthData[7]),
      MonthlyReg('Sep', widget.allMonthData[8]),
      MonthlyReg('Oct', widget.allMonthData[9]),
      MonthlyReg('Nov', widget.allMonthData[10]),
      MonthlyReg('Dec', widget.allMonthData[11]),
    ];
    dailyData = initializeRegData();
  }

  List<RegData> initializeRegData() {
    return List.generate(
      widget.allDay.length,
      (index) => RegData((index + 1).toString(), widget.allDay[index].toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 410,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kWhiteTextColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    IconlyLight.user3,
                    color: kGreyTextColor,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    selectedMonth == 'This Month' ? 'Plan subscribers (current month)' : 'Plan subscribers (current year)',
                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                    height: 36,
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: kBorderColorTextField),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: getCategories(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: List.generate(
                    800 ~/ 2,
                    (index) => Expanded(
                          child: Container(
                            color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                            height: 1,
                          ),
                        )),
              ),
              const SizedBox(height: 20.0),
              Visibility(
                visible: selectedMonth == 'This Month',
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  plotAreaBorderColor: Colors.transparent,
                  legend: const Legend(
                    isVisible: true,
                    alignment: ChartAlignment.center,
                    position: LegendPosition.top,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<RegData, String>>[
                    ColumnSeries<RegData, String>(
                      width: 0.3,
                      legendIconType: LegendIconType.circle,
                      dataSource: dailyData,
                      xValueMapper: (RegData day, _) => day.day,
                      yValueMapper: (RegData count, _) => count.count,
                      name: 'Subscribers ${widget.totalSubscribers}',
                      color: Colors.blue,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      // Enable data label
                      dataLabelSettings: const DataLabelSettings(isVisible: false),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: selectedMonth == 'Yearly',
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SfCartesianChart(
                    primaryXAxis: const CategoryAxis(),
                    plotAreaBorderColor: Colors.transparent,
                    legend: const Legend(
                      isVisible: true,
                      alignment: ChartAlignment.center,
                      position: LegendPosition.top,
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<MonthlyReg, String>>[
                      ColumnSeries<MonthlyReg, String>(
                        width: 0.1,
                        legendIconType: LegendIconType.circle,
                        dataSource: data,
                        xValueMapper: (MonthlyReg sales, _) => sales.month,
                        yValueMapper: (MonthlyReg sales, _) => sales.count,
                        name: 'Subscribers ${widget.totalSubscribers}',
                        color: Colors.blue,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                        // Enable data label
                        dataLabelSettings: const DataLabelSettings(isVisible: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RegData {
  RegData(this.day, this.count);

  final String day;
  final double count;
}
class MonthlyReg {
  MonthlyReg(this.month, this.count);

  final String month;
  final double count;
}

class StatisticsData extends StatefulWidget {
  const StatisticsData(
      {Key? key,
      required this.totalIncomeCurrentYear,
      required this.totalIncomeCurrentMonths,
      required this.totalIncomeLastMonth,
      required this.allMonthData,
      required this.allDay,
      required this.totalUser,
      required this.freeUser})
      : super(key: key);
  final double totalIncomeCurrentYear;
  final double totalIncomeCurrentMonths;
  final double totalIncomeLastMonth;
  final List<double> allMonthData;
  final List<int> allDay;
  final double totalUser;
  final double freeUser;

  @override
  State<StatisticsData> createState() => _StatisticsDataState();
}

class _StatisticsDataState extends State<StatisticsData> {
  List<MonthlyIncomeData> data = [
    MonthlyIncomeData('Jan', 0),
    MonthlyIncomeData('Feb', 0),
    MonthlyIncomeData('Mar', 0),
    MonthlyIncomeData('Apr', 0),
    MonthlyIncomeData('May', 0),
    MonthlyIncomeData('Jun', 0),
    MonthlyIncomeData('July', 0),
    MonthlyIncomeData('Aug', 0),
    MonthlyIncomeData('Sep', 0),
    MonthlyIncomeData('Oct', 0),
    MonthlyIncomeData('Nov', 0),
    MonthlyIncomeData('Dec', 0),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [
      MonthlyIncomeData('Jan', widget.allMonthData[0]),
      MonthlyIncomeData('Feb', widget.allMonthData[1]),
      MonthlyIncomeData('Mar', widget.allMonthData[2]),
      MonthlyIncomeData('Apr', widget.allMonthData[3]),
      MonthlyIncomeData('May', widget.allMonthData[4]),
      MonthlyIncomeData('Jun', widget.allMonthData[5]),
      MonthlyIncomeData('Jul', widget.allMonthData[6]),
      MonthlyIncomeData('Aug', widget.allMonthData[7]),
      MonthlyIncomeData('Sep', widget.allMonthData[8]),
      MonthlyIncomeData('Oct', widget.allMonthData[9]),
      MonthlyIncomeData('Nov', widget.allMonthData[10]),
      MonthlyIncomeData('Dec', widget.allMonthData[11]),
    ];
    dailyData = initializeSalesData();
  }

  List<String> monthList = [
    'This Month',
    'Yearly',
  ];

  String selectedMonth = 'Yearly';

  DropdownButton<String> getCategories() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in monthList) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(
          des,
          style: const TextStyle(color: kTitleColor, fontWeight: FontWeight.normal, fontSize: 14),
        ),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(Icons.keyboard_arrow_down),
      padding: EdgeInsets.zero,
      items: dropDownItems,
      value: selectedMonth,
      onChanged: (value) {
        setState(() {
          selectedMonth = value!;
        });
      },
    );
  }

  final ScrollController stockInventoryScrollController = ScrollController();

  late List<DailyIncomeData> dailyData;

  List<DailyIncomeData> initializeSalesData() {
    return List.generate(
      widget.allDay.length,
      (index) => DailyIncomeData((index + 1).toString(), widget.allDay[index].toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double percentageChange = 0.0;
    double freePercentage = ((widget.freeUser * 100) / widget.totalUser);
    double paidPercentage = 100 - freePercentage;
    print(freePercentage);
    print(paidPercentage);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //________________________________________________Statistics______
        Expanded(
          flex: 2,
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: kBorderColorTextField.withOpacity(0.1), blurRadius: 4, blurStyle: BlurStyle.inner, spreadRadius: 1, offset: const Offset(0, 1))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: kBorderColorTextField))),
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  height: 52,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(IconlyLight.activity, color: kGreyTextColor),
                      const SizedBox(width: 10.0),
                      Text(
                        'Statistic (Total income)',
                        style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: kTitleColor, fontSize: 20.0),
                      ),
                      const Spacer(),
                      Container(
                        height: 36,
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: kBorderColorTextField),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: getCategories(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Visibility(
                  visible: selectedMonth == 'Yearly',
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SfCartesianChart(
                      borderWidth: 1.0,
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      primaryXAxis: const CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      plotAreaBorderColor: Colors.transparent,
                      legend: const Legend(
                        isVisible: true,
                        alignment: ChartAlignment.center,
                        position: LegendPosition.top,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<MonthlyIncomeData, String>>[
                        SplineSeries<MonthlyIncomeData, String>(
                          splineType: SplineType.natural,
                          legendIconType: LegendIconType.circle,
                          dataSource: data,
                          xValueMapper: (MonthlyIncomeData sales, _) => sales.month,
                          yValueMapper: (MonthlyIncomeData sales, _) => sales.sales,
                          name: 'Total income: \$${widget.totalIncomeCurrentYear}',
                          color: kBlueTextColor,
                          enableTooltip: true,
                          // borderRadius: const BorderRadius.only(
                          //   topRight: Radius.circular(30.0),
                          //   topLeft: Radius.circular(30.0),
                          // ),
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedMonth == 'This Month',
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SfCartesianChart(
                      borderWidth: 1.0,
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      primaryXAxis: const CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      plotAreaBorderColor: Colors.transparent,
                      legend: const Legend(
                        isVisible: true,
                        alignment: ChartAlignment.center,
                        position: LegendPosition.top,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<DailyIncomeData, String>>[
                        SplineSeries<DailyIncomeData, String>(
                          splineType: SplineType.natural,
                          legendIconType: LegendIconType.circle,
                          dataSource: dailyData,
                          xValueMapper: (DailyIncomeData sales, _) => sales.day,
                          yValueMapper: (DailyIncomeData sales, _) => sales.sales,
                          name: 'Total income: \$${widget.totalIncomeCurrentYear}',
                          color: kBlueTextColor,
                          enableTooltip: true,
                          // borderRadius: const BorderRadius.only(
                          //   topRight: Radius.circular(30.0),
                          //   topLeft: Radius.circular(30.0),
                          // ),
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MonthlyIncomeData {
  MonthlyIncomeData(this.month, this.sales);

  final String month;
  final double sales;
}

class DailyIncomeData {
  DailyIncomeData(this.day, this.sales);

  final String day;
  final double sales;
}

class UserOverView extends StatefulWidget {
  const UserOverView(
      {super.key,
      required this.free,
      required this.monthly,
      required this.yearly,
      required this.lifeTime,
      required this.freeSubOfYear,
      required this.monthlySubOfYear,
      required this.yearlySubOfYear});

  final double free;
  final double freeSubOfYear;
  final double monthly;
  final double monthlySubOfYear;
  final double yearly;
  final double yearlySubOfYear;
  final double lifeTime;

  @override
  State<UserOverView> createState() => _UserOverViewState();
}

class _UserOverViewState extends State<UserOverView> {
  late Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();
  }

  final colorList = <Color>[
    Colors.deepPurple,
    Colors.green,
    kBlueTextColor,
    kBlueTextColor.withOpacity(0.3),
  ];
  int touchedIndex = -1;

  List<String> monthList = [
    'This Month',
    'Yearly',
  ];

  String selectedMonth = 'This Month';

  DropdownButton<String> getCategories() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in monthList) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(
          des,
          style: const TextStyle(color: kTitleColor, fontWeight: FontWeight.normal, fontSize: 14),
        ),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(Icons.keyboard_arrow_down),
      padding: EdgeInsets.zero,
      items: dropDownItems,
      value: selectedMonth,
      onChanged: (value) {
        setState(() {
          selectedMonth = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: kBorderColorTextField.withOpacity(0.1),
            blurRadius: 4,
            blurStyle: BlurStyle.inner,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: kBorderColorTextField))),
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            height: 52,
            child: Row(
              children: [
                const Icon(IconlyLight.ticketStar, color: kGreyTextColor),
                const SizedBox(width: 10.0),
                Text(
                  'Subscription Plan',
                  style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                const Spacer(),
                Container(
                  height: 36,
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: kBorderColorTextField),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: getCategories(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: selectedMonth == 'This Month',
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                touchedIndex = event.isInterestedForInteractions && pieTouchResponse != null && pieTouchResponse.touchedSection != null
                                    ? pieTouchResponse.touchedSection!.touchedSectionIndex
                                    : -1;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: selectedMonth == 'Yearly',
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                touchedIndex = event.isInterestedForInteractions && pieTouchResponse != null && pieTouchResponse.touchedSection != null
                                    ? pieTouchResponse.touchedSection!.touchedSectionIndex
                                    : -1;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Colors.deepPurple,
                        text: 'Free Plan:',
                        isSquare: false,
                        percent: selectedMonth == 'Yearly' ? widget.freeSubOfYear.toString() : widget.free.toString(),
                      ),
                      const SizedBox(height: 16),
                      Indicator(
                        color: Colors.green,
                        text: 'Monthly:',
                        isSquare: false,
                        percent: selectedMonth == 'Yearly' ? widget.monthlySubOfYear.toString() : widget.monthly.toString(),
                      ),
                      const SizedBox(height: 16),
                      Indicator(
                        color: CupertinoColors.systemPink,
                        text: 'Yearly:',
                        isSquare: false,
                        percent: selectedMonth == 'Yearly' ? widget.yearlySubOfYear.toString() : widget.yearly.toString(),
                      ),
                      const SizedBox(height: 16),
                      const Indicator(
                        color: Colors.deepOrangeAccent,
                        text: 'Lifetime:',
                        isSquare: false,
                        percent: '0.0',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    const List<Color> sectionColors = [
      Colors.deepPurple,
      Colors.green,
      CupertinoColors.systemPink,
      Colors.deepOrangeAccent,
    ];

    List<double> monthly = [widget.free, widget.monthly, widget.yearly, widget.lifeTime];
    List<double> yearly = [widget.freeSubOfYear, widget.monthlySubOfYear, widget.yearlySubOfYear, widget.lifeTime];

    final List<PieChartSectionData> sections = List.generate(sectionColors.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 50.0 : 40.0;

      return PieChartSectionData(
        showTitle: true,
        color: sectionColors[i],
        value: selectedMonth == 'This Month' ? monthly[i] : yearly[i],
        title: selectedMonth == 'This Month' ? '${monthly[i]}' : '${yearly[i]}',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      );
    });

    return sections;
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.percent,
    required this.isSquare,
    this.size = 12,
    this.textColor,
  });

  final Color color;
  final String text;
  final String percent;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        RichText(
          text: TextSpan(text: text, style: const TextStyle(color: kGreyTextColor, overflow: TextOverflow.ellipsis), children: [
            TextSpan(
              text: percent,
              style: const TextStyle(color: kTitleColor, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
            )
          ]),
        ),
      ],
    );
  }
}
