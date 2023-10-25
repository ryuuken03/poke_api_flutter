import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_api/view/pages/splash_page.dart';

void main() async{
  await dotenv.load(fileName: "lib/.env" );
  runApp(ProviderScope(
    child:  MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routes: {
        SplashPage.routeName: (context) => const SplashPage(),
      },
      initialRoute: SplashPage.routeName,
    );
  }
}
