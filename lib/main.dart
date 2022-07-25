import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:note_app/servicers/service.dart';
import 'package:note_app/view/home.dart';

void setLocator(){
  GetIt.I.registerLazySingleton(() => Service());
}

void main() {
  setLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}


