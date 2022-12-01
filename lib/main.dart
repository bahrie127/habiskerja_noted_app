import 'package:flutter/material.dart';
import 'package:flutter_notes_app/pages/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'utils/user_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSharedPreferences.init();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
