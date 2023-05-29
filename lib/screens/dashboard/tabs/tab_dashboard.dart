import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db/db_helper.dart';
import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:expense_tracker/screens/dashboard/tabs/widget/screen_add_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  int totalAmount = 0;

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
    for (int i = 0; i < mAddDataModel.length; i++) {
      Map<String, double> tempDataMap = {
        if (mAddDataModel[i].type! == AppString.textExpense)
          mAddDataModel[i].category!: 10,
      };
      dataMap.addAll(tempDataMap);
      setState(() {});

      if (mAddDataModel[i].type == AppString.textIncome) {
        totalIncome = totalIncome + mAddDataModel[i].amount!;
      } else {
        totalExpense = totalExpense + mAddDataModel[i].amount!;
      }
    }
    totalAmount = totalIncome - totalExpense;
    setState(() {});
  }

  removeData(int index) async {
    dbHelper = DbHelper();
    await dbHelper.deleteData(mAddDataModel[index].id!);
    totalIncome = 0;
    totalExpense = 0;
    initData();
    setState(() {});
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
                  totalIncome = 0;
                  totalExpense = 0;
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
                    "\$ $totalAmount",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.textSize16),
                  ),
                ],
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
                  AddDataModel item = mAddDataModel[index];
                  return Slidable(
                    key: UniqueKey(),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        removeData(index);
                      }),
                      children: [
                        SlidableAction(
                          onPressed: (i) {
                            removeData(index);
                          },
                          backgroundColor: AppColors.colorRed,
                          foregroundColor: AppColors.colorWhite,
                          icon: Icons.delete,
                          label: AppString.textDelete,
                        ),
                        /* SlidableAction(
                          onPressed: () {},
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                          label: 'Share',
                        ),*/
                      ],
                    ),

                    // The end action pane is the one at the right or the bottom side.
                    /* endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: () {},
                          backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Archive',
                        ),
                        SlidableAction(
                          onPressed: () {},
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.save,
                          label: 'Save',
                        ),
                      ],
                    ),*/
                    child: ListTile(
                      title: Text(
                        'Type : ${item.type!}',
                        style: const TextStyle(
                            color: AppColors.colorBlack,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'Date time : ${item.date!}',
                        style: const TextStyle(color: AppColors.colorBlack),
                      ),
                      trailing: Text(
                        '\$ ${item.amount!.toString()}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: Dimens.textSize16,
                            color: item.type! == AppString.textIncome
                                ? AppColors.colorGreen
                                : AppColors.colorRed),
                      ),
                    ),
                  );

                  /*Card(
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

                              */
                  /*IconButton(
                                onPressed: () {
                                  removeData(index);
                                },
                                icon: const Icon(
                                  Icons.delete_outlined,
                                  color: AppColors.colorRed,
                                ),
                              ),*/
                  /*
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
                  );*/
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
