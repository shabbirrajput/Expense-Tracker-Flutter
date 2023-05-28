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
  dynamic totalIncome = 0;
  dynamic totalExpense = 0;

  String dropDownValue = '';
  Map<String, double> dataMap = {};

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
    for (int i = 0; i < mAddDataModel.length; i++) {
      Map<String, double> tempDataMap = {
        if (mAddDataModel[i].type! == AppString.textExpense)
          mAddDataModel[i].category!: 10,
      };
      dataMap.addAll(tempDataMap);
      if (mAddDataModel[i].type == AppString.textIncome) {
        totalIncome = totalIncome + mAddDataModel[i].amount!;
        debugPrint('totalIncome = ${totalIncome + mAddDataModel[i].amount!}');
      } else {
        totalExpense = totalExpense + mAddDataModel[i].amount!;
      }
    }
    /*  for (int i = 0; i < mAddDataModel.length; i++) {
      print('object');

    }*/
  }

  removeData(int index) async {
    dbHelper = DbHelper();
    await dbHelper.deleteData(mAddDataModel[index].id!);
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenAddData(
                onAddData: () {
                  initData();
                },
              ),
            ),
          );
        },
        backgroundColor: AppColors.colorPrimary,
        child: const Icon(
          Icons.add,
          color: AppColors.colorWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.margin20),
          child: Column(
            children: [
              const SizedBox(
                height: Dimens.margin10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppString.textTotalBalance,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.textSize16),
                  ),
                  Text(
                    "${totalIncome - totalExpense}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.textSize16),
                  ),
                ],
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
              if (dataMap.isNotEmpty)
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Type : ${item.type!}',
                                style: const TextStyle(
                                    color: AppColors.colorBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\$ ${item.amount!.toString()}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: Dimens.textSize16,
                                    color: item.type! == AppString.textIncome
                                        ? AppColors.colorGreen
                                        : AppColors.colorRed),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date time : ${item.date!}',
                                style: const TextStyle(
                                    color: AppColors.colorBlack),
                              ),
                              Text(
                                item.time!,
                                style: const TextStyle(
                                    color: AppColors.colorBlack),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimens.margin10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                AppString.textCategory,
                                style: TextStyle(color: AppColors.colorBlack),
                              ),
                              Text(
                                item.category!,
                                style: const TextStyle(
                                    color: AppColors.colorBlack),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimens.margin10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                AppString.textPaymentMethod,
                                style: TextStyle(color: AppColors.colorBlack),
                              ),
                              Text(
                                item.paymentMethod!,
                                style: const TextStyle(
                                    color: AppColors.colorBlack),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimens.margin10,
                          ),
                          if (item.paymentMethod == AppString.textCheque)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  AppString.textStatus,
                                  style: TextStyle(color: AppColors.colorBlack),
                                ),
                                Text(
                                  item.status!,
                                  style: const TextStyle(
                                      color: AppColors.colorBlack),
                                ),
                              ],
                            ),
                          if (item.paymentMethod == AppString.textCheque)
                            const SizedBox(
                              height: Dimens.margin10,
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                AppString.textNotes,
                                style: TextStyle(color: AppColors.colorBlack),
                              ),
                              Text(
                                item.note!,
                                style: const TextStyle(
                                    color: AppColors.colorBlack),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
