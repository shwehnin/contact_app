import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_app/service_locator.dart';
import 'package:contact_app/blocs/get/cubit/get_contact_cubit.dart';
import 'package:contact_app/pages/contact/screen/contact_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocator();
  return runApp(MyContactApp());
}

class MyContactApp extends StatelessWidget {
  const MyContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        primaryColor: Colors.indigoAccent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
        ),
      ),
      home: BlocProvider<GetContactCubit>(
        create: (context) => getIt.call(),
        child: ContactPage(),
      ),
    );
  }
}
