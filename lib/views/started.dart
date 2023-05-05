import 'package:flutter/material.dart';
import 'package:lungscancer/views/home.dart';
import 'package:lungscancer/views/signin_screen.dart';



class Started extends StatelessWidget {
  const Started({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 15, 62, 129),

      body: SafeArea(

        child: Column(
          children: [
            Container(
              height: 500,
              decoration: BoxDecoration(color: const Color.fromARGB(
                  255, 4, 26, 55),),
              child: Image.asset(
                "assets/images/start.jpg",
                // height: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // height: 90,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: const Color.fromARGB(
                  255, 7, 31, 61),),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "التطبيق الاول للتنؤ بسرطان الرئة",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 78.0),
                      child: Text(textAlign: TextAlign.center,
                        "قم باستعراض حالتك المرضية بوجود أفضل الدكاترة المختصين في البمن",
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninScreen()//HomeScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 25),
                          width: 400,
                          height: 60,
                          decoration: BoxDecoration(
                              color:  const Color.fromARGB(
                                  255, 30, 91, 166),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Center(
                            child: Text(
                              ".....أبدا الآن",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    )
                    // InkWell(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
