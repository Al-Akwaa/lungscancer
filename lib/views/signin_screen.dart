import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lungscancer/providers/User_Provider.dart';
import 'package:lungscancer/screens/Login_screen.dart';
import 'package:lungscancer/views/SignUp_screen.dart';
import 'package:lungscancer/widgets/custom_divider.dart';
import 'package:lungscancer/widgets/wave.dart';


class SigninScreen extends ConsumerWidget {
  const SigninScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authUserProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 62, 129),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              /*  SvgPicture.asset(
                  'assets/images/start.jpg',
                  height: 200,
                ),*/
                const Wave(),
              ],
            ),
            Container(

              width: double.infinity,
             // color: const Color(0xff1F1147),
              color: const Color.fromARGB(254, 92, 132, 218),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    const Text(
                      'تسجيل الدخول',
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                     auth.isLoginState==false? LoginForm(isSignUp: false):SignUp(),
                    const CustomDivider(),

                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height > 700 ? 150 : 70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
