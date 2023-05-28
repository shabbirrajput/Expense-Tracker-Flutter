import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:flutter/material.dart';

class ScreenHistory extends StatefulWidget {
  final Function onAddData;
  const ScreenHistory({Key? key, required this.onAddData}) : super(key: key);

  @override
  State<ScreenHistory> createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  List<AddDataModel> mAddDataModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: mAddDataModel.length,
            itemBuilder: (context, index) {
              print('LENGTH${mAddDataModel.length}');
              AddDataModel item = mAddDataModel[index];
              return Column(
                children: [Text(item.category!)],
              );
            }));
  }
}
