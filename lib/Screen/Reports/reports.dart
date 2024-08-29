import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Provider/seller_info_provider.dart';
import '../Footer/footer.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Constant Data/export_button.dart';
import '../Widgets/Pop Up/Reports/view_reports.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  static const String route = '/reports';

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  void showViewReportPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const ViewReport(),
        );
      },
    );
  }

  int _productsPerPage = 10; // Default number of items to display
  int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      body: Consumer(
        builder: (_, ref, watch) {
          final reports = ref.watch(sellerInfoProvider);
          return reports.when(data: (reports) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 240,
                    child: SideBarWidget(
                      index: 3,
                      isTab: false,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width < 1275 ? 1275 - 240 : MediaQuery.of(context).size.width - 240,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: kWhiteTextColor,
                            ),
                            child: const TopBar(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteTextColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'REPORTS',
                                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(8.0, 4, 8.0, 4.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text('Result-'),
                                            DropdownButton<int>(
                                              isDense: true,
                                              padding: EdgeInsets.zero,
                                              underline: const SizedBox(),
                                              value: _productsPerPage,
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                              ),
                                              items: [10, 20, 50, 100, -1].map<DropdownMenuItem<int>>((int value) {
                                                return DropdownMenuItem<int>(
                                                  value: value,
                                                  child: Text(
                                                    value == -1 ? "All" : value.toString(),
                                                    style: const TextStyle(color: Colors.black),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (int? newValue) {
                                                setState(() {
                                                  if (newValue == -1) {
                                                    _productsPerPage = -1; // Set to -1 for "All"
                                                  } else {
                                                    _productsPerPage = newValue ?? 10;
                                                  }
                                                  _currentPage = 1;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width * .25,
                                        child: TextField(
                                          showCursor: true,
                                          cursorColor: kTitleColor,
                                          decoration: kInputDecoration.copyWith(
                                            hintText: 'Search Anything...',
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  color: kBlueTextColor,
                                                ),
                                                child: const Icon(FeatherIcons.search, color: kWhiteTextColor),
                                              ),
                                            ),
                                            hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                                            contentPadding: const EdgeInsets.all(4.0),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      const ExportButton()
                                    ],
                                  ).visible(false),
                                  const SizedBox(height: 10.0).visible(false),
                                  SizedBox(
                                    height:
                                    (MediaQuery.of(context).size.height - 140).isNegative ? 0 : MediaQuery.of(context).size.height - 140,
                                    width: MediaQuery.of(context).size.width < 1275 ? 1275 - 240 : MediaQuery.of(context).size.width - 240,

                                    child: SingleChildScrollView(
                                      child: DataTable(
                                        border: TableBorder.all(
                                          color: kBorderColorTextField,
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        dividerThickness: 1.0,
                                        headingRowColor: MaterialStateProperty.all(kDarkWhite),
                                        showBottomBorder: true,
                                        headingTextStyle: kTextStyle.copyWith(color: kTitleColor, fontSize: 14.0),
                                        dataTextStyle: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 12.0),
                                        horizontalMargin: 20.0,
                                        columnSpacing: 20.0,
                                        columns: const [
                                          DataColumn(
                                            label: Text('DATE'),
                                          ),
                                          DataColumn(
                                            label: Text('SHOP NAME'),
                                          ),
                                          DataColumn(
                                            label: Text('CATEGORY'),
                                          ),
                                          DataColumn(
                                            label: Text('PACKAGE'),
                                          ),
                                          DataColumn(
                                            label: Text('START'),
                                          ),
                                          DataColumn(
                                            label: Text('END'),
                                          ),
                                          DataColumn(
                                            label: Text('METHOD'),
                                          ),
                                          DataColumn(
                                            label: Text('ACTION'),
                                          ),
                                        ],
                                        rows: List.generate(
                                          // reports.length,
                                            _productsPerPage == -1
                                                ? reports.length
                                                : (_currentPage - 1) * _productsPerPage + _productsPerPage <= reports.length
                                                ? _productsPerPage
                                                : reports.length - (_currentPage - 1) * _productsPerPage,
                                          (index) {
                                            final dataIndex = (_currentPage - 1) * _productsPerPage + index;
                                            final report = reports[dataIndex];
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                  Text(report.subscriptionDate?.substring(0, 10) ?? ''),
                                                ),
                                                DataCell(
                                                  SizedBox(
                                                      width: 220,
                                                      child: Text(report.companyName ?? '',style: const TextStyle(overflow: TextOverflow.ellipsis),)),
                                                ),
                                                DataCell(
                                                  Text(report.businessCategory ?? ''),
                                                ),
                                                DataCell(
                                                  Text(report.subscriptionName ?? ''),
                                                ),
                                                DataCell(
                                                  Text(report.subscriptionDate?.substring(0, 10) ?? ''),
                                                ),
                                                DataCell(
                                                  Text(report.subscriptionDate?.substring(0, 10) ?? ''),
                                                ),
                                                DataCell(
                                                  Text(report.subscriptionMethod ?? ''),
                                                ),
                                                DataCell(
                                                  PopupMenuButton(
                                                    icon: const Icon(FeatherIcons.moreVertical, size: 18.0),
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (BuildContext bc) => [
                                                      PopupMenuItem(
                                                        child: GestureDetector(
                                                          onTap: (() => showViewReportPopUp()),
                                                          child: Row(
                                                            children: [
                                                              const Icon(FeatherIcons.eye, size: 18.0, color: kTitleColor),
                                                              const SizedBox(width: 4.0),
                                                              Text(
                                                                'View',
                                                                style: kTextStyle.copyWith(color: kTitleColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                    onSelected: (value) {
                                                      Navigator.pushNamed(context, '$value');
                                                    },
                                                    surfaceTintColor: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'showing ${((_currentPage - 1) * _productsPerPage + 1).toString()} to ${((_currentPage - 1) * _productsPerPage + _productsPerPage).clamp(0, reports.length)} of ${reports.length} entries',
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            InkWell(
                                              overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
                                              hoverColor: Colors.grey,
                                              onTap: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
                                              child: Container(
                                                height: 32,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: kBorderColorTextField),
                                                  borderRadius: const BorderRadius.only(
                                                    bottomLeft: Radius.circular(4.0),
                                                    topLeft: Radius.circular(4.0),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Text('Previous'),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: kMainColor),
                                                color: kMainColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '$_currentPage',
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              hoverColor: Colors.blue.withOpacity(0.1),
                                              overlayColor: MaterialStateProperty.all<Color>(Colors.blue),
                                              onTap: _currentPage * _productsPerPage < reports.length
                                                  ? () => setState(() => _currentPage++)
                                                  : null,
                                              child: Container(
                                                height: 32,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: kBorderColorTextField),
                                                  borderRadius: const BorderRadius.only(
                                                    bottomRight: Radius.circular(4.0),
                                                    topRight: Radius.circular(4.0),
                                                  ),
                                                ),
                                                child: const Center(child: Text('Next')),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Footer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }, error: (e, stack) {
            return Center(
              child: Text(e.toString()),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
        },
      ),
    );
  }
}
