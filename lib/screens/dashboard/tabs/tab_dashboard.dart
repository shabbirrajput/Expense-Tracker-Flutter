import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_list.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db/db_helper.dart';
import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:expense_tracker/screens/dashboard/tabs/widget/screen_add_data.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabDashboard extends StatefulWidget {
  const TabDashboard({Key? key}) : super(key: key);

  @override
  State<TabDashboard> createState() => _TabDashboardState();
}

class _TabDashboardState extends State<TabDashboard> {
  late DbHelper dbHelper;
  List<AddDataModel> mAddDataModel = [];

  String dropDownValue = '';
  Map<String, double> dataMap = {
    "Travel": 40,
    "House": 30,
    "Food": 20,
    "Other": 10,
  };

  final colorList = <Color>[
    AppColors.colorPrimary,
    AppColors.colorGreen,
    AppColors.colorRed,
    AppColors.colorGrey,
  ];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    dbHelper = DbHelper();
    mAddDataModel =
        await dbHelper.getAddedData(sp.getString(AppConfig.textUserId));
    setState(() {});
  }

  removeData(int index) async {
    dbHelper = DbHelper();
    await dbHelper.deleteData(mAddDataModel[index].id!);
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.margin20),
        child: Column(
          children: [
            const SizedBox(
              height: Dimens.margin10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: dropDownValue.isNotEmpty ? dropDownValue : null,
                  icon: const Icon(Icons.arrow_drop_down),
                  hint: const Text(AppString.textSelectMonth),
                  items: itemMonthList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: Dimens.margin10,
            ),
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 2.2,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.disc,
              ringStrokeWidth: 32,
              centerText: "Expense Chart",
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                // legendShape: _BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 0,
              ),
              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            ),
            const SizedBox(
              height: Dimens.margin10,
            ),
            ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: mAddDataModel.length,
              itemBuilder: (context, index) {
                print('object ---> ${mAddDataModel.length}');
                AddDataModel item = mAddDataModel[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppString.textType,
                              style: TextStyle(
                                  color: AppColors.colorBlack,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              item.type!,
                              style: const TextStyle(
                                  color: AppColors.colorBlack,
                                  fontWeight: FontWeight.w500),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                item.amount!.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: item.type! == AppString.textIncome
                                        ? AppColors.colorGreen
                                        : AppColors.colorRed),
                              ),
                            ),
                            const SizedBox(
                              width: 145,
                            ),
                            /*IconButton(
                              onPressed: () {
                                removeData(index);
                              },
                              icon: const Icon(
                                Icons.delete_outlined,
                                color: AppColors.colorRed,
                              ),
                            ),*/
                          ],
                        ),
                        const SizedBox(
                          height: Dimens.margin10,
                        ),
                        Text(
                          item.date!,
                          style: const TextStyle(color: AppColors.colorBlack),
                        ),
                        const SizedBox(
                          height: Dimens.margin10,
                        ),
                        Text(
                          item.time!,
                          style: const TextStyle(color: AppColors.colorBlack),
                        ),
                        const SizedBox(
                          height: Dimens.margin10,
                        ),
                        Text(
                          item.category!,
                          style: const TextStyle(color: AppColors.colorBlack),
                        ),
                        const SizedBox(
                          height: Dimens.margin10,
                        ),
                        Text(
                          item.paymentMethod!,
                          style: const TextStyle(color: AppColors.colorBlack),
                        ),
                        const SizedBox(
                          height: Dimens.margin10,
                        ),
                        Text(
                          item.status!,
                          style: const TextStyle(color: AppColors.colorBlack),
                        ),
                        const SizedBox(
                          height: Dimens.margin10,
                        ),
                        Text(
                          item.note!,
                          style: const TextStyle(color: AppColors.colorBlack),
                        ),
                        const SizedBox(
                          height: Dimens.margin10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.margin18),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenAddData(
                                  onAddData: () {
                                    initData();
                                  },
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(Dimens.margin20),
                    backgroundColor: AppColors.colorPrimary,
                    foregroundColor: AppColors.colorWhite,
                  ),
                  child: const Icon(Icons.add, color: AppColors.colorWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
