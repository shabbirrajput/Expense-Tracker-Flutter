import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db/db_helper.dart';
import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHistory extends StatefulWidget {
  final Function onAddData;
  const ScreenHistory({Key? key, required this.onAddData}) : super(key: key);

  @override
  State<ScreenHistory> createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  late DbHelper dbHelper;
  List<AddDataModel> mAddDataModel = [];
  String dropDownValue = '';

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

  ///Select Month
  DateTime selectedMonth = DateTime.now();

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedMonth,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.colorPrimary, // header background color
              onPrimary: AppColors.colorBlack, // header text color
              onSurface: AppColors.colorGrey, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.colorPrimary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedMonth) {
      setState(() {
        selectedMonth = picked;
        String formattedDate = DateFormat('MM').format(picked);
        // Output: 25/05/2023
        monthController.value =
            TextEditingValue(text: formattedDate.toString());
      });
    }
  }

  ///Select Year
  DateTime selectedYear = DateTime.now();

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedYear,
      initialDatePickerMode: DatePickerMode.year,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.colorPrimary, // header background color
              onPrimary: AppColors.colorBlack, // header text color
              onSurface: AppColors.colorGrey, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.colorPrimary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedYear) {
      setState(() {
        selectedYear = picked;
        String formattedDate = DateFormat('yyyy').format(picked);
        // Output: 25/05/2023
        yearController.value = TextEditingValue(text: formattedDate.toString());
      });
    }
  }

/*  void getFilteredData(String date) async {
    dbHelper = DbHelper();
    mAddDataModel = await dbHelper.getFilter(mAddDataModel[date].date!);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: Dimens.margin10,
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.margin16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => _selectMonth(context),
                child: SizedBox(
                  height: SizeConfig().heightSize(context, 6.0),
                  width: SizeConfig().widthSize(context, 45.0),
                  child: TextFormField(
                    enabled: false,
                    controller: monthController,
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(color: AppColors.colorBlack),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: AppString.textSelectMonth,
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => _selectYear(context),
                child: SizedBox(
                  height: SizeConfig().heightSize(context, 6.0),
                  width: SizeConfig().widthSize(context, 42.0),
                  child: TextFormField(
                    enabled: false,
                    controller: yearController,
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(color: AppColors.colorBlack),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: AppString.textSelectYear,
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: AppColors.colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        /*Row(
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
        ),*/
        SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: ListView.builder(
              shrinkWrap: true,
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
                              style:
                                  const TextStyle(color: AppColors.colorBlack),
                            ),
                            Text(
                              item.time!,
                              style:
                                  const TextStyle(color: AppColors.colorBlack),
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
                              style:
                                  const TextStyle(color: AppColors.colorBlack),
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
                              style:
                                  const TextStyle(color: AppColors.colorBlack),
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
                              style:
                                  const TextStyle(color: AppColors.colorBlack),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    ));
  }
}
