import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/month_list.dart';
import 'package:flutter/material.dart';

class ScreenAddData extends StatefulWidget {
  final Function onProductAdd;

  const ScreenAddData({Key? key, required this.onProductAdd}) : super(key: key);

  @override
  State<ScreenAddData> createState() => _ScreenAddDataState();
}

class _ScreenAddDataState extends State<ScreenAddData> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productQtyController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  /*var dbHelper;*/
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  ///Select Date
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.value = TextEditingValue(text: picked.toString());
      });
    }
  }

  ///Select Time
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
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
    if (picked != null && picked != _timeOfDay) {
      setState(() {
        _timeOfDay = picked;
        timeController.value = TextEditingValue(text: picked.toString());
      });
    }
  }

  ///Add Category
  List<String> categories = [];

  void addCategory() {
    setState(() {
      categories.add('New Category');
    });
  }

  String dropDownValue = '';
  @override
  void initState() {
    super.initState();
    /* readJson();*/

    // dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.textAddIncomeOrExpense,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColors.colorPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: Dimens.margin24,
            ),
            const SizedBox(
              height: Dimens.margin24,
            ),
            SizedBox(
              height: Dimens.margin72,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.margin20),
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: TextFormField(
                    enabled: false,
                    controller: dateController,
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(color: AppColors.colorBlack),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: AppString.textSelectDate,
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
            ),
            SizedBox(
              height: Dimens.margin72,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.margin20),
                child: InkWell(
                  onTap: () => _selectTime(context),
                  child: TextFormField(
                    enabled: false,
                    controller: timeController,
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(color: AppColors.colorBlack),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: AppString.textSelectTime,
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Icon(
                        Icons.watch_later_outlined,
                        color: AppColors.colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimens.margin72,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.margin20),
                child: DropdownButton(
                  value: dropDownValue.isNotEmpty ? dropDownValue : null,
                  icon: const Icon(Icons.arrow_drop_down),
                  hint: const Text(AppString.textSelectType),
                  items: itemSelectTypeList.map((String items) {
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
              ),
            ),
            SizedBox(
              height: Dimens.margin72,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.margin20),
                child: TextFormField(
                  controller: productImageController,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(color: AppColors.colorBlack),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: "AppString.textAddImage",
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            SizedBox(
              height: Dimens.margin72,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.margin20),
                child: TextFormField(
                  controller: productDescController,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(color: AppColors.colorBlack),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: "AppString.textDesc",
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "AppString.textSelectCategoryType",
                  style: TextStyle(
                    color: AppColors.colorPrimary,
                    /*fontWeight: FontWeight.w500*/
                  ),
                ),
                /*SizedBox(
                  height: Dimens.margin50,
                  width: Dimens.margin100,
                  child: DropdownButton<Category>(
                    // Step 3.
                    value: selectCategory,
                    isExpanded: true,
                    // Step 4.
                    items: catList
                        .map<DropdownMenuItem<Category>>((Category value) {
                      return DropdownMenuItem<Category>(
                        value: value,
                        child: Text(
                          value.name!,
                          style: const TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: Dimens.margin20),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (Category? newValue) {
                      setState(() {
                        selectCategory = newValue!;
                      });
                    },
                  ),
                ),*/
              ],
            ),

            /* const SizedBox(
                                height: Dimens.margin72,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimens.margin20),
                                    child: Text(
                                      AppString.textSelectCategoryType,
                                      style: TextStyle(
                                          color: AppColors.colorPrimary,
                                          fontSize: Dimens.margin16,

                                          fontWeight: FontWeight.w500),
                                    )),
                              ),*/
            const SizedBox(
              height: Dimens.margin18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.margin20),
              child: Row(
                children: [
                  SizedBox(
                    height: Dimens.margin46,
                    width: Dimens.margin170,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        disabledForegroundColor: AppColors.colorPrimary,
                        side: const BorderSide(color: AppColors.colorPrimary),
                      ),
                      child: const Text(
                        AppString.textCancel,
                        style: TextStyle(
                          color: AppColors.colorPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: Dimens.margin8,
                  ),
                  SizedBox(
                    height: Dimens.margin46,
                    width: Dimens.margin170,
                    child: ElevatedButton(
                      onPressed: () {
                        /*addProduct();*/
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          backgroundColor: AppColors.colorPrimary),
                      child: const Text(
                        AppString.textAdd,
                        style: TextStyle(
                          color: AppColors.colorWhite2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
