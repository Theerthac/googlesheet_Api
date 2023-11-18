import 'package:flutter/material.dart';
import 'package:googlesheet/api/user_sheets_api.dart';
import 'package:googlesheet/view/sheet_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Google Sheets API';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SheetPage(),
    );
  }
}
