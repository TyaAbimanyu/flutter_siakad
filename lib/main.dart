import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/bloc/bloc/login_bloc.dart';
import 'package:flutter_siakad_app/data/datasources/auth_local_datasources.dart';
import 'package:flutter_siakad_app/page/auth/auth_page.dart';
import 'package:flutter_siakad_app/page/auth/splash_page.dart';
import 'package:flutter_siakad_app/page/mahasiswa/mahasiswa_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: FutureBuilder<bool>(
          future: AuthLocalDatasources().isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return const MahasiswaPage();
              } else {
                return const AuthPage();
              }
            } else {
              return const SplashPage();
            }
          },
        ),
      ),
    );
  }
}
