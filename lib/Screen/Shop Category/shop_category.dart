// ignore_for_file: unused_result, use_build_context_synchronously

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/Provider/shop_category_provider.dart';
import 'package:salespro_saas_admin/model/shop_category_model.dart';

import '../Footer/footer.dart';
import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Constant Data/export_button.dart';
import '../Widgets/Pop Up/Shop Category/edit_category.dart';
import '../Widgets/Pop Up/Shop Category/new_category.dart';
import '../Widgets/Pop Up/Shop Category/view_category.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';

class ShopCategory extends StatefulWidget {
  const ShopCategory({Key? key}) : super(key: key);

  static const String route = '/shopCategory';

  @override
  State<ShopCategory> createState() => _ShopCategoryState();
}

class _ShopCategoryState extends State<ShopCategory> {
  Future<void> deleteCategory({required WidgetRef updateRef, required String name}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext dialogContext) {
          return Center(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Are you want to delete this Category?',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(dialogContext);
                          },
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          child: Container(
                            width: 130,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async {
                            EasyLoading.show(status: 'Deleting..');
                            String key = '';
                            await FirebaseDatabase.instance.ref().child('Admin Panel').child('Category').orderByKey().get().then((value) async {
                              for (var element in value.children) {
                                var data = jsonDecode(jsonEncode(element.value));
                                if (data['categoryName'].toString() == name) {
                                  key = element.key.toString();
                                }
                              }
                            });
                            DatabaseReference ref = FirebaseDatabase.instance.ref("Admin Panel/Category/$key");
                            await ref.remove();
                            updateRef.refresh(shopCategoryProvider);

                            EasyLoading.showSuccess('Done');
                            Navigator.pop(dialogContext);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  //Add New Category PopUp
  void showAddCategoryPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const NewCategory(),
        );
      },
    );
  }

  //VIEW Category PopUp
  void showViewCategoryPopUP(ShopCategoryModel category) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ViewCategory(categoryModel: category),
        );
      },
    );
  }

  //Show Edit Category
  void showEditCategory(ShopCategoryModel edit) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: EditCategory(editCategory: edit),
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
          AsyncValue<List<ShopCategoryModel>> categoryList = ref.watch(shopCategoryProvider);
          return categoryList.when(data: (categoryList) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 240,
                    child: SideBarWidget(
                      index: 2,
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
                                      ),const SizedBox(width: 20.0),
                                      GestureDetector(
                                        onTap: (() => showAddCategoryPopUp()),
                                        child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: kBlueTextColor),
                                          child: Column(
                                            children: [
                                              Text(
                                                'ADD NEW CATEGORY',
                                                style: kTextStyle.copyWith(color: kWhiteTextColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
                                        headingTextStyle: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                                        dataTextStyle: kTextStyle.copyWith(color: kGreyTextColor),
                                        columns: const [
                                          DataColumn(
                                            label: Text('S.L'),
                                          ),
                                          DataColumn(
                                            label: Text('CATEGORY NAME'),
                                          ),
                                          DataColumn(
                                            label: Text('DESCRIPTION'),
                                          ),
                                          DataColumn(
                                            label: Text('CREATED BY'),
                                          ),
                                          DataColumn(
                                            label: Text('ACTION'),
                                          ),
                                        ],
                                        rows: List.generate(
                                          // categoryList.length,
                                            _productsPerPage == -1
                                                ? categoryList.length
                                                : (_currentPage - 1) * _productsPerPage + _productsPerPage <= categoryList.length
                                                ? _productsPerPage
                                                : categoryList.length - (_currentPage - 1) * _productsPerPage,
                                          (index) {
                                            final dataIndex = (_currentPage - 1) * _productsPerPage + index;
                                            final category = categoryList[dataIndex];
                                            return DataRow(
                                              cells: [
                                                DataCell(
                                                  Text((index + 1).toString()),
                                                ),
                                                DataCell(
                                                  Text(category.categoryName ?? ''),
                                                ),
                                                DataCell(
                                                  Text(category.description ?? ''),
                                                ),
                                                const DataCell(
                                                  Text('Admin'),
                                                ),
                                                DataCell(
                                                  PopupMenuButton(
                                                    icon: const Icon(FeatherIcons.moreVertical, size: 18.0),
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (BuildContext bc) => [
                                                      PopupMenuItem(
                                                        child: GestureDetector(
                                                          onTap: (() => showViewCategoryPopUP(
                                                            categoryList[index],
                                                          )),
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
                                                      PopupMenuItem(
                                                        child: GestureDetector(
                                                          onTap: (() => showEditCategory(category)),
                                                          child: Row(
                                                            children: [
                                                              const Icon(FeatherIcons.edit3, size: 18.0, color: kTitleColor),
                                                              const SizedBox(width: 4.0),
                                                              Text(
                                                                'Edit',
                                                                style: kTextStyle.copyWith(color: kTitleColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        child: GestureDetector(
                                                          onTap: categoryList.length <= 1
                                                              ? () {
                                                            EasyLoading.showError('You have to keep one category');
                                                          }
                                                              : () async {
                                                            await deleteCategory(name: category.categoryName ?? '', updateRef: ref);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              const Icon(Icons.delete_outline, size: 18.0, color: kTitleColor),
                                                              const SizedBox(width: 4.0),
                                                              Text(
                                                                'Delete',
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
                                          'showing ${((_currentPage - 1) * _productsPerPage + 1).toString()} to ${((_currentPage - 1) * _productsPerPage + _productsPerPage).clamp(0, categoryList.length)} of ${categoryList.length} entries',
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
                                              onTap: _currentPage * _productsPerPage < categoryList.length
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
