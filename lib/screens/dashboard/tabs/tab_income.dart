import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/core/month_list.dart';
import 'package:expense_tracker/screens/dashboard/tabs/widget/screen_add_data.dart';
import 'package:flutter/material.dart';

class TabIncome extends StatefulWidget {
  const TabIncome({Key? key}) : super(key: key);

  @override
  State<TabIncome> createState() => _TabIncomeState();
}

class _TabIncomeState extends State<TabIncome> {
  String dropDownValue = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.margin16),
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
          Expanded(
            child: ListView.builder(
                /*shrinkWrap: true,*/
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Text(
                    AppString.textIncome,
                    style: TextStyle(color: AppColors.colorBlack),
                  );
                }),
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
                          builder: (context) =>
                              ScreenAddData(onProductAdd: () {})));
                  /*   showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ScreenAddData(
                        onProductAdd: () {
                          */ /*initData();*/ /*
                          Navigator.pop(context);
                        },
                      );
                    },
                  );*/
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
    );
  }
}
