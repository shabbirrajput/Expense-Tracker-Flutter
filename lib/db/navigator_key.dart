import 'package:flutter/material.dart';

/// Used by [NavigatorKey] of app and web
class NavigatorKey {
  static final navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'navigator');
  static final dropDownKey = GlobalKey(debugLabel: 'dropDown');
  static final dismissKey = GlobalKey(debugLabel: 'dismiss');
}
