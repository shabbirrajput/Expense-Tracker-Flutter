import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:flutter/material.dart';

class AddProductSheet extends StatefulWidget {
  final Function onProductAdd;

  const AddProductSheet({Key? key, required this.onProductAdd})
      : super(key: key);

  @override
  State<AddProductSheet> createState() => _AddProductSheetState();
}

class _AddProductSheetState extends State<AddProductSheet> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productQtyController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();
  final TextEditingController productDescController = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    /* readJson();*/

    // dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.margin600,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: Dimens.margin24,
            ),
            Padding(
              padding: const EdgeInsets.only(right: Dimens.margin16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "AppString.textAddProducts",
                        style: TextStyle(
                          color: AppColors.colorBlack,
                          fontSize: Dimens.margin20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: AppColors.colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Dimens.margin24,
            ),
            SizedBox(
              height: Dimens.margin72,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.margin20),
                child: TextFormField(
                  controller: productNameController,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(color: AppColors.colorBlack),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: "AppString.textAddName",
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
                  controller: productPriceController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.colorBlack),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: "AppString.textAddPrice",
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
                  controller: productQtyController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.colorBlack),
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.colorWhite2,
                      border: InputBorder.none,
                      hintText: "AppString.textAddQty",
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
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        disabledForegroundColor: AppColors.colorPrimary,
                        side: const BorderSide(color: AppColors.colorPrimary),
                      ),
                      child: const Text(
                        "AppString.textCancel",
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
                        "AppString.textAdd",
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
