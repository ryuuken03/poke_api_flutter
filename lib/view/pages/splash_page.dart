import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_api/view/pages/pokemon_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  static const String routeName = "/splash";

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}


void pushToHome(BuildContext context) {
  // print("Push to Home");
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Navigator.pushReplacementNamed(context, MainPage.routeName);
     Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return PokemonPage(url: "https://pokeapi.co/api/v2/pokemon/");
        },
      ),);
  });
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var counterProgress = 1;
  @override
  void initState() {
    addCounter();
    super.initState();
  }
  void addCounter() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        print("count : {$counterProgress}");
        if (counterProgress == 5) {
          pushToHome(context);
        } else {
          counterProgress++;
          addCounter();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Simulator Data',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )
    );
  }
}