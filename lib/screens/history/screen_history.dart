import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db/db_helper.dart';
import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHistory extends StatefulWidget {
  final Function onAddData;
  const ScreenHistory({Key? key, required this.onAddData}) : super(key: key);

  @override
  State<ScreenHistory> createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  late DbHelper dbHelper;
  List<AddDataModel> mAddDataModel = [];

  @override
  void initState() {
    print('In init data');
    initData();
    super.initState();
  }

  void initData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    dbHelper = DbHelper();
    mAddDataModel =
        await dbHelper.getAddedData(sp.getString(AppConfig.textUserId));
    setState(() {});
    print('objectHistory');
    print('object lrngth ${mAddDataModel.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            physics: const ScrollPhysics(),
            itemCount: mAddDataModel.length,
            itemBuilder: (context, index) {
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
                            style: const TextStyle(color: AppColors.colorBlack),
                          ),
                          Text(
                            item.time!,
                            style: const TextStyle(color: AppColors.colorBlack),
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
                            style: const TextStyle(color: AppColors.colorBlack),
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
                            style: const TextStyle(color: AppColors.colorBlack),
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
                              style:
                                  const TextStyle(color: AppColors.colorBlack),
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
                            style: const TextStyle(color: AppColors.colorBlack),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
