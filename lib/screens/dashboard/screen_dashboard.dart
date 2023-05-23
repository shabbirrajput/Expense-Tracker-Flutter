import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/screens/auth/screen_login.dart';
import 'package:expense_tracker/screens/dashboard/tabs/tab_expense.dart';
import 'package:expense_tracker/screens/dashboard/tabs/tab_income.dart';
import 'package:expense_tracker/screens/history/screen_history.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int selectedIndex = 0;

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({Key? key}) : super(key: key);

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onLogout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenLogin()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Drawer drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: Dimens.margin100,
          ),
          ListTile(
            leading: IconButton(
              color: AppColors.colorPrimary,
              onPressed: () {},
              icon: const Icon(
                Icons.attach_money_outlined,
                color: AppColors.colorGreen,
              ),
            ),
            title: const Text(AppString.textIncome),
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: IconButton(
              color: AppColors.colorPrimary,
              onPressed: () {},
              icon: const Icon(
                Icons.attach_money_outlined,
                color: AppColors.colorRed,
              ),
            ),
            title: const Text(AppString.textExpense),
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: IconButton(
              color: AppColors.colorPrimary,
              onPressed: () {},
              icon: const Icon(Icons.history),
            ),
            title: const Text(AppString.textHistory),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: IconButton(
              color: AppColors.colorPrimary,
              onPressed: () {},
              icon: Icon(Icons.logout_outlined),
            ),
            title: const Text(AppString.textLogout),
            onTap: () {
              showAlertDialog(context);
            },
          ),
        ],
      ),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          tabBarTheme: const TabBarTheme(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppColors.colorWhite))),
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text(
                AppString.textDashboard,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: IconButton(
                icon: const Icon(Icons.view_headline_sharp),
                onPressed: () {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState!.openEndDrawer();
                  } else {
                    scaffoldKey.currentState!.openDrawer();
                  }
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScreenHistory()));
                    },
                    icon: const Icon(Icons.history))
              ],
              backgroundColor: AppColors.colorPrimary,
              automaticallyImplyLeading: false,
              bottom: const TabBar(
                tabs: [
                  Tab(text: AppString.textIncome),
                  Tab(text: AppString.textExpense)
                ],
              ),
            ),
            drawer: drawer,
            body: const TabBarView(
              children: [
                TabIncome(),
                TabExpense(),
              ],
            ),
            /*IndexedStack(
              index: selectedIndex,
              children: [
                ScreenDashboard(
                  viewAllCategory: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),
                const TabIncome(),
                const TabExpense(),
                const ScreenHistory(),
              ],
            ),*/ //
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text("log Out"),
      onPressed: () {
        onLogout();
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Log Out"),
      content: const Text("Are you sure you want to Log Out?"),
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
