import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/Provider/seller_info_provider.dart';
import 'package:salespro_saas_admin/Screen/Widgets/Pop%20Up/Shop%20Management/view_shop.dart';
import 'package:salespro_saas_admin/model/seller_info_model.dart';

import '../Footer/footer.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Constant Data/export_button.dart';
import '../Widgets/Pop Up/Shop Management/edit_shop.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class ShopManagement extends StatefulWidget {
  const ShopManagement({Key? key}) : super(key: key);

  static const String route = '/shopManagement';

  @override
  State<ShopManagement> createState() => _ShopManagementState();
}

class _ShopManagementState extends State<ShopManagement> {
  //View Shop PopUp
  void showViewShopPopUp(SellerInfoModel info) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ViewShop(
            infoModel: info,
          ),
        );
      },
    );
  }

  //Edit Shop PopUp
  void showEditShopPopUp(SellerInfoModel shopInfo) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: EditShop(shopInformation: shopInfo),
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
          final sellerInfo = ref.watch(sellerInfoProvider);
          return sellerInfo.when(data: (sellerInfo) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 240,
                    child: SideBarWidget(
                      index: 1,
                      isTab: false,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width < 1275 ? 1275 - 240 : MediaQuery.of(context).size.width - 240,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            // width: double.infinity,
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
                                        'SHOP LIST',
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
                                      const ExportButton().visible(false)
                                    ],
                                  ),
                                  // const SizedBox(height: 10.0),
                                  // SizedBox(
                                  //   height: 40,
                                  //   width: MediaQuery.of(context).size.width * .25,
                                  //   child: TextField(
                                  //     showCursor: true,
                                  //     cursorColor: kTitleColor,
                                  //     decoration: kInputDecoration.copyWith(
                                  //       hintText: 'Search Anything...',
                                  //       suffixIcon: Padding(
                                  //         padding: const EdgeInsets.all(4.0),
                                  //         child: Container(
                                  //           decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(8.0),
                                  //             color: kBlueTextColor,
                                  //           ),
                                  //           child: const Icon(FeatherIcons.search, color: kWhiteTextColor),
                                  //         ),
                                  //       ),
                                  //       hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                                  //       contentPadding: const EdgeInsets.all(4.0),
                                  //       enabledBorder: const OutlineInputBorder(
                                  //         borderRadius: BorderRadius.all(
                                  //           Radius.circular(8.0),
                                  //         ),
                                  //         borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 10.0),
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
                                        // horizontalMargin: 20.0,

                                        columnSpacing: 20.0,

                                        columns: const [
                                          DataColumn(
                                            label: Text('S.L'),
                                          ),
                                          DataColumn(
                                            label: Text('LOGO'),
                                          ),
                                          DataColumn(
                                            label: Text('SHOP NAME'),
                                          ),
                                          DataColumn(
                                            label: Text('CATEGORY'),
                                          ),
                                          DataColumn(
                                            label: Text('PHONE'),
                                          ),
                                          DataColumn(
                                            label: Text('EMAIL'),
                                          ),
                                          DataColumn(
                                            label: Text('PACKAGE'),
                                          ),
                                          DataColumn(
                                            label: Text('METHOD'),
                                          ),
                                          DataColumn(
                                            label: Text('ACTION'),
                                          ),
                                        ],
                                        rows: List.generate(
                                          _productsPerPage == -1
                                              ? sellerInfo.length
                                              : (_currentPage - 1) * _productsPerPage + _productsPerPage <= sellerInfo.length
                                              ? _productsPerPage
                                              : sellerInfo.length - (_currentPage - 1) * _productsPerPage,
                                          (index){
                                            final dataIndex = (_currentPage - 1) * _productsPerPage + index;
                                            final seller = sellerInfo[dataIndex];
                                            return  DataRow(
                                              cells: [
                                                DataCell(
                                                  Text('${(_currentPage - 1) * _productsPerPage + index + 1}'),

                                                ),
                                                DataCell(
                                                  CircleAvatar(
                                                    radius: 20.0,
                                                    backgroundImage: NetworkImage(seller.pictureUrl ?? ''),
                                                  ),
                                                ),
                                                DataCell(
                                                  SizedBox(child: SizedBox(
                                                      width: 220,
                                                      child: Text(seller.companyName ?? '',style: TextStyle(overflow: TextOverflow.ellipsis,)))),
                                                ),
                                                DataCell(
                                                  Text(seller.businessCategory ?? ''),
                                                ),
                                                DataCell(
                                                  Text(seller.phoneNumber ?? ''),
                                                ),
                                                DataCell(
                                                  Text(seller.email ?? ''),
                                                ),
                                                DataCell(
                                                  Text(seller.subscriptionName ?? ''),
                                                ),
                                                DataCell(
                                                  Text(seller.subscriptionMethod ?? ''),
                                                ),
                                                DataCell(
                                                  PopupMenuButton(

                                                    icon: const Icon(FeatherIcons.moreVertical, size: 18.0),
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (BuildContext bc) => [
                                                      PopupMenuItem(
                                                        child: GestureDetector(
                                                          onTap: (() => showViewShopPopUp(seller)),
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
                                                      // PopupMenuItem(
                                                      //   child: GestureDetector(
                                                      //     onTap: (() => showEditShopPopUp(sellerInfo[index])),
                                                      //     child: Row(
                                                      //       children: [
                                                      //         const Icon(FeatherIcons.edit3, size: 18.0, color: kTitleColor),
                                                      //         const SizedBox(width: 4.0),
                                                      //         Text(
                                                      //           'Edit',
                                                      //           style: kTextStyle.copyWith(color: kTitleColor),
                                                      //         ),
                                                      //       ],
                                                      //     ).visible(false),
                                                      //   ),
                                                      // ),
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
                                          'showing ${((_currentPage - 1) * _productsPerPage + 1).toString()} to ${((_currentPage - 1) * _productsPerPage + _productsPerPage).clamp(0, sellerInfo.length)} of ${sellerInfo.length} entries',
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
                                              onTap: _currentPage * _productsPerPage < sellerInfo.length
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
