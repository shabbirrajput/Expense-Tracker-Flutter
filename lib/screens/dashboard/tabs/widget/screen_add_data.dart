import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_config.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/app_list.dart';
import 'package:expense_tracker/db/comHelper.dart';
import 'package:expense_tracker/db/db_helper.dart';
import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenAddData extends StatefulWidget {
  /*final AddDataModel mAddDataModel;*/
  final Function onAddData;

  const ScreenAddData(
      {Key? key, required this.onAddData /*, required this.mAddDataModel*/})
      : super(key: key);

  @override
  State<ScreenAddData> createState() => _ScreenAddDataState();
}

class _ScreenAddDataState extends State<ScreenAddData> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  late DbHelper dbHelper;
  List<AddDataModel> mAddDataModel = [];

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

  addData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String addDate = dateController.text;
    String addTime = timeController.text;
    String addType = dropDownValueType;
    String addCategory = categoryController.text;
    String addAmount = amountController.text;
    String addPaymentMethod = paymentController.text;
    String addStatus = dropDownValueStatus;
    String addNote = noteController.text;

    if (addDate.isEmpty) {
      alertDialog("Please Select Date");
    } else if (addTime.isEmpty) {
      alertDialog("Please Select Time");
    } else if (addType.isEmpty) {
      alertDialog("Please Select Type");
    } else if (addCategory.isEmpty) {
      alertDialog("Please Select Category");
    } else if (addPaymentMethod.isEmpty) {
      alertDialog("Please Select Payment Method");
    } else if (addStatus.isEmpty) {
      alertDialog("Please Select Status");
    } else if (addNote.isEmpty) {
      alertDialog("Please Enter Note");
    } else {
      AddDataModel mAddDataModel = AddDataModel();

      mAddDataModel.date = addDate;
      mAddDataModel.time = addTime;
      mAddDataModel.type = addType;
      mAddDataModel.category = addCategory;
      mAddDataModel.amount = addAmount;
      mAddDataModel.paymentMethod = addPaymentMethod;
      mAddDataModel.status = addStatus;
      mAddDataModel.note = addNote;
      mAddDataModel.addDataUserId = sp.getString(AppConfig.textUserId);
      print('AddData ---> ${mAddDataModel}');

      dbHelper = DbHelper();
      await dbHelper.saveAddData(mAddDataModel).then((addData) {
        widget.onAddData();
        print({mAddDataModel.id});
      }).catchError((error) {
        alertDialog("Error: Data Save Fail--$error");
      });
    }
  }

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

  String dropDownValueType = '';
  String dropDownValueStatus = '';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.margin20),
        child: SingleChildScrollView(
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
              SizedBox(
                height: Dimens.margin72,
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
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Icon(
                        Icons.select_all,
                        color: AppColors.colorPrimary,
                      ),
                    ),
                    // isEmpty: dropDownValueType == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropDownValueType.isNotEmpty
                            ? dropDownValueType
                            : null,
                        hint: const Text(AppString.textSelectType),
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValueType = newValue!;
                            state.didChange(newValue);
                          });
                        },
                        items: itemSelectTypeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: Dimens.margin18,
              ),
              SizedBox(
                height: Dimens.margin72,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: Dimens.margin600,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /*GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: mAddDataModel.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    AddDataModel item = mAddDataModel[index];
                                    print('Length---> ${mAddDataModel.length}');
                                    debugPrint(
                                        'object ---> ${mAddDataModel[index].addDataUserId}');

                                    return Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.category)),
                                        Text(item.category!),
                                      ],
                                    );
                                  },
                                ),*/
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: mAddDataModel.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    AddDataModel item = mAddDataModel[index];
                                    return GestureDetector(onTap: () {
                                      // Get the index of the selected item.
                                      final selectedIndex = index;

                                      // Pass the index to the bottom sheet text field.
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Column(
                                              children: [
                                                Text(
                                                  '$selectedIndex',
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.category)),
                                                Text(item.category!),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    });
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    showAlertDialogCategory(context);
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: TextFormField(
                    /* onChanged: (value) {
                      setState(() {
                        newCategoryName = value;
                      });
                    },*/
                    enabled: false,
                    // controller: categoryController,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(color: AppColors.colorBlack),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: AppString.textSelectCategory,
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Icon(
                        Icons.category_outlined,
                        color: AppColors.colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                minLines: Dimens.margin2.toInt(),
                maxLines: Dimens.margin5.toInt(),
                style: const TextStyle(color: AppColors.colorBlack),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.colorWhite2,
                  border: InputBorder.none,
                  hintText: AppString.textEnterAmount,
                  hintStyle: TextStyle(
                      color: AppColors.colorGrey, fontWeight: FontWeight.w500),
                  prefixIcon: Icon(
                    Icons.money_outlined,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimens.margin18,
              ),
              SizedBox(
                height: Dimens.margin72,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: Dimens.margin600,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: mAddDataModel.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    AddDataModel item = mAddDataModel[index];
                                    print('Length---> ${mAddDataModel.length}');
                                    debugPrint(
                                        'object ---> ${mAddDataModel[index].addDataUserId}');

                                    return Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.payment_outlined)),
                                        Text(item.paymentMethod!),
                                      ],
                                    );
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      showAlertDialogPayment(context);
                                    },
                                    icon: const Icon(Icons.add))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: TextFormField(
                    enabled: false,
                    // controller: paymentController,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(color: AppColors.colorBlack),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: AppString.textSelectPaymentMethod,
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Icon(
                        Icons.payment_outlined,
                        color: AppColors.colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: AppString.textSelectCategory,
                      hintStyle: TextStyle(
                          color: AppColors.colorGrey,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Icon(
                        Icons.auto_graph_outlined,
                        color: AppColors.colorPrimary,
                      ),
                    ),
                    // isEmpty: dropDownValueType == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropDownValueStatus.isNotEmpty
                            ? dropDownValueStatus
                            : null,
                        hint: const Text(AppString.textSelectStatus),
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValueStatus = newValue!;
                            state.didChange(newValue);
                          });
                        },
                        items: itemSelectStatusList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: Dimens.margin18,
              ),
              TextFormField(
                controller: noteController,
                keyboardType: TextInputType.multiline,
                minLines: Dimens.margin2.toInt(),
                maxLines: Dimens.margin5.toInt(),
                style: const TextStyle(color: AppColors.colorBlack),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.colorWhite2,
                  border: InputBorder.none,
                  hintText: AppString.textNote,
                  hintStyle: TextStyle(
                      color: AppColors.colorGrey, fontWeight: FontWeight.w500),
                  prefixIcon: Icon(
                    Icons.note_add_outlined,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimens.margin18,
              ),
              Row(
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
                        addData();
                        initData();
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
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialogCategory(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(AppString.textCancel),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(AppString.textAdd),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(AppString.textAlert),
      content: TextFormField(
        controller: categoryController,
        keyboardType: TextInputType.multiline,
        minLines: Dimens.margin2.toInt(),
        maxLines: Dimens.margin5.toInt(),
        style: const TextStyle(color: AppColors.colorBlack),
        decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.colorWhite2,
          border: InputBorder.none,
          hintText: AppString.textEnterCategory,
          hintStyle: TextStyle(
              color: AppColors.colorGrey, fontWeight: FontWeight.w500),
          prefixIcon: Icon(
            Icons.add_circle_outline_outlined,
            color: AppColors.colorPrimary,
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogPayment(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(AppString.textCancel),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(AppString.textAdd),
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(AppString.textAlert),
      content: TextFormField(
        controller: paymentController,
        keyboardType: TextInputType.multiline,
        minLines: Dimens.margin2.toInt(),
        maxLines: Dimens.margin5.toInt(),
        style: const TextStyle(color: AppColors.colorBlack),
        decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.colorWhite2,
          border: InputBorder.none,
          hintText: AppString.textEnterPaymentMethod,
          hintStyle: TextStyle(
              color: AppColors.colorGrey, fontWeight: FontWeight.w500),
          prefixIcon: Icon(
            Icons.add_circle_outline_outlined,
            color: AppColors.colorPrimary,
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
