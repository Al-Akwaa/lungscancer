

import 'package:lungscancer/views/home.dart';
import 'package:lungscancer/views/signin_screen.dart';

class AppRoute {
  const AppRoute._();

  static const home = '/home';
  static const signin = '/signin';
  static const welcome = '/welcome';


  static final routes = {
    home: (context) => const MainView(),
  signin: (context)=>const SigninScreen(),
  };
}
