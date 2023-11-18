import 'package:flutter/material.dart';
import 'package:googlesheet/api/user_sheets_api.dart';
import 'package:googlesheet/main.dart';
import 'package:googlesheet/view/userform_widget.dart';

class SheetPage extends StatelessWidget {
  const SheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: UserFormWidget(onSavedUser: (user) async {
              final id = await UserSheetApi.getRowCount() + 1;
              final newUser = user.copy(id: id);
              await UserSheetApi.insert([newUser.toJson()]);
            })));
  }
}
