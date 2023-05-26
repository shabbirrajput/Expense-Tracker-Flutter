import 'package:expense_tracker/core/app_color.dart';
import 'package:expense_tracker/core/app_dimens.dart';
import 'package:expense_tracker/core/app_string.dart';
import 'package:expense_tracker/db/navigator_key.dart';
import 'package:expense_tracker/screens/auth/screen_login.dart';
import 'package:expense_tracker/screens/dashboard/tabs/tab_dashboard.dart';
import 'package:expense_tracker/screens/history/screen_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({Key? key}) : super(key: key);

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onLogout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    Navigator.of(NavigatorKey.navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenLogin()),
        (Route<dynamic> route) => false);
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) => onLogout());
    } catch (e) {
      onLogout();
    }
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
                color: AppColors.colorPrimary,
              ),
            ),
            title: const Text(AppString.textDashboard),
            onTap: () {
              _onItemTapped(0);
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
              _onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: IconButton(
              color: AppColors.colorPrimary,
              onPressed: () {},
              icon: const Icon(Icons.logout_outlined),
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
              title: Text(
                selectedIndex == 0
                    ? AppString.textDashboard
                    : AppString.textHistory,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  if (scaffoldKey.currentState!.isDrawerOpen) {
                    scaffoldKey.currentState!.openEndDrawer();
                  } else {
                    scaffoldKey.currentState!.openDrawer();
                  }
                },
              ),
/*              actions: [
                if (selectedIndex == 0)
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TabDashboard()));
                      },
                      icon: const Icon(Icons.history))
              ],*/
              backgroundColor: AppColors.colorPrimary,
              automaticallyImplyLeading: false,
/*              bottom: const TabBar(
                tabs: [
                  Tab(text: AppString.textIncome),
                  Tab(text: AppString.textExpense)
                ],
              ),*/
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.attach_money_outlined),
                      backgroundColor: AppColors.colorPrimary,
                      label: AppString.textDashboard),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    backgroundColor: AppColors.colorPrimary,
                    label: AppString.textHistory,
                  ),
                ],
                type: BottomNavigationBarType.shifting,
                currentIndex: selectedIndex,
                selectedItemColor: selectedIndex == 0
                    ? AppColors.colorBlack
                    : AppColors.colorBlack,
                iconSize: Dimens.margin40,
                onTap: _onItemTapped,
                elevation: Dimens.margin5),
            drawer: drawer,
            body: IndexedStack(
              index: selectedIndex,
              children: const [TabDashboard(), ScreenHistory()],
            ),

            /* const TabBarView(
              children: [
                TabIncome(),
                TabExpense(),
              ],
            ),*/
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
            ),*/
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
        _signOut();

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
