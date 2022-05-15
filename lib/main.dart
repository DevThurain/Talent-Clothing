import 'package:flutter/material.dart';
import 'package:talent_clothing/persistent/hive_constants.dart';
import 'package:talent_clothing/persistent/models/user_data.dart';

import 'app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await _initializeHive();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp());
}

_initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());

  await Hive.openBox<UserData>(HiveConstants.BOX_NAME_USER_DATA);
}
