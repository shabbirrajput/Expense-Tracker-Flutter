import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/app_list.dart';
import 'package:flutter/material.dart';

class ScreenAddData extends StatefulWidget {
  final Function onProductAdd;

  const ScreenAddData({Key? key, required this.onProductAdd}) : super(key: key);

  @override
  State<ScreenAddData> createState() => _ScreenAddDataState();
}

class _ScreenAddDataState extends State<ScreenAddData> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  /*var dbHelper;*/

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

  String newCategoryName = '';

  String dropDownValueType = '';
  String dropDownValueStatus = '';
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
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: 9,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.local_pizza_outlined)),
                                        const Text('Pizza'),
                                      ],
                                    );
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (newCategoryName.isNotEmpty) {
                                        setState(() {
                                          categories.add(newCategoryName);
                                        });
                                      }
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
                    onChanged: (value) {
                      setState(() {
                        newCategoryName = value;
                      });
                    },
                    enabled: false,
                    controller: categoryController,
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
                                  itemCount: 9,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.payment_outlined)),
                                        const Text('Card'),
                                      ],
                                    );
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (newCategoryName.isNotEmpty) {
                                        setState(() {
                                          categories.add(newCategoryName);
                                        });
                                      }
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
                    controller: paymentController,
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
              /*DropdownButton(
                value:
                    dropDownValueStatus.isNotEmpty ? dropDownValueStatus : null,
                icon: const Icon(Icons.arrow_drop_down),
                hint: const Text(AppString.textSelectStatus),
                items: itemSelectStatusList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValueStatus = newValue!;
                  });
                },
              ),*/
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
            ],
          ),
        ),
      ),
    );
  }
}
