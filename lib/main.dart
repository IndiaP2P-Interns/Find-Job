import 'package:flutter/material.dart';
import 'package:find_job/core/di/app_module.dart';
import 'package:find_job/core/nav/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpLocator();
  runApp(MyApp());
  // runApp(
  //   MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: JobHomePage(),
  //     theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Find Job',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
