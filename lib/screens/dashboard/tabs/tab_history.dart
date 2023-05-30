import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_list.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db/db_helper.dart';
import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHistory extends StatefulWidget {
  const ScreenHistory({Key? key}) : super(key: key);

  @override
  State<ScreenHistory> createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  late DbHelper dbHelper;
  List<AddDataModel> mAddDataModel = [];
  String dropDownValue = '';
  String month = '';

  @override
  void initState() {
    super.initState();
  }

  void getDateList() {
    for (int i = 0; i < mAddDataModel.length; i++) {
      if (monthController.text == mAddDataModel[i].date) {}
    }
  }

  void getSelectedMonth() async {
    dbHelper = DbHelper();
    final getMonth = await dbHelper.getFilteredByLike(month);
    setState(
      () {
        dropDownValue = getMonth.toString();
      },
    );
  }

  Future<List<Map<String, dynamic>>> checkF() async {
    dbHelper = DbHelper();
    final getResultData = await dbHelper.getData();
    return getResultData;
  }

  void getFilteredData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    dbHelper = DbHelper();
    mAddDataModel = await dbHelper
        .getAddedData(sp.getString(AppConfig.textUserId))
        .then((value) {
      for (int i = 0; i < mAddDataModel.length; i++) {
        String mDate = mAddDataModel[i].date!;

        if (dropDownValue == mDate) {
          dbHelper.getFilteredByLike(mDate);
        }
      }
      setState(() {});
      return value;
    });
  }

/*    for (int i = 0; i < mAddDataModel.length; i++) {
      debugPrint('Date ${mAddDataModel[i].date}');
      if (monthController.text == mAddDataModel[i].date!) {
        print('monthController ${monthController.text}');
      } else {
        print('Error');
      }
    }*/

  /* void getFilteredData() async {
    for (int i = 0; i < mAddDataModel.length; i++) {
      String mDate = mAddDataModel[i].date!;
      print('SPLIT month --> $mDate');
      if (monthController.text == mDate) {
        dbHelper.getFilter(mDate).then((value) {
          setState(() {});
        });
        print('monthController ${monthController.text}');
      } else {
        print('Error');
      }
    }
  }*/

/*
  void getFilteredData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    dbHelper = DbHelper();
    mAddDataModel =
        await dbHelper.getAddedData(sp.getString(AppConfig.textUserId));
    setState(() {});
    for (int i = 0; i < mAddDataModel.length; i++) {
      final date = DateTime.parse('2023-06-29');
      final monthString = DateFormat('MM').format(date);
      print('SPLIT month --> $monthString');
      if (monthController.text == mAddDataModel[i].date) {
          dbHelper.getFilter(mAddDataModel[i].date!,sp.getString(AppConfig.textUserId)).then((value) {
          setState(() {});
        });
        print('monthController ${monthController.text}');
      } else {
        print('Error');
      }
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.margin16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: dropDownValue.isNotEmpty ? dropDownValue : null,
                  icon: const Icon(Icons.arrow_drop_down),
                  hint: const Text(AppString.textSelectMonth),
                  items: itemMonthListFormatted.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      getFilteredData();
                      dropDownValue = newValue!;
                    });
                  },
                ),
              ],
            ),

            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _selectMonth(context).then((value) {
                    checkF();
                    setState(() {});
                  }),
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
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
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
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.colorPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),*/
          ),
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
                }),
          ),
        ],
      ),
    ));
  }
}

/*
*
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
        String formattedDate = DateFormat('MMM d, yyyy').format(picked);
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
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        // Output: 25/05/2023
        yearController.value = TextEditingValue(text: formattedDate.toString());
      });
    }
  }
*/
