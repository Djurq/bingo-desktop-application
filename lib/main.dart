import 'package:bingochart_app/pages/change_bingocards.dart';
import 'package:bingochart_app/pages/edit_bingocard.dart';
import 'package:bingochart_app/pages/home.dart';
import 'package:bingochart_app/pages/select_bingocard.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
void main() async{

    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Homepage(),
        '/change': (context) => const ChangeBingocards(),
        '/select': (context) => const SelectBingocard(),

      }
    );
  }
}
