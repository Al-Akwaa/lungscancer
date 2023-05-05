import 'package:flutter/material.dart';
import 'package:lungscancer/views/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungscancer/views/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lungscancer/Core/index.dart';
import 'package:lungscancer/providers/User_Provider.dart';
import 'package:lungscancer/providers/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  // await Firebase.initializeApp();

  runApp(ProviderScope(
      overrides: [spProvider.overrideWithValue(sharedPreferences)],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final auth = ref.watch(authUserProvider);
      final futureAuth = ref.watch(futureAuthProviders);
      return MaterialApp(

        debugShowCheckedModeBanner: false,

        title: 'تطبيق التنؤ بسرطان الرئة',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        home: futureAuth.when(data: (data) {
          return auth.isAuth ? MainView() : SigninScreen();
        }, error: (e, st) {
          return Scaffold(
            body: Center(child: Text(e.toString())),
          );
        }, loading: () {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }),
        routes: AppRoute.routes,
      );
    });


  }
}
