import 'package:flutter/material.dart';
import 'package:lungscancer/providers/User_Provider.dart';
import 'package:lungscancer/views/UploadImage_screen.dart';
import 'package:lungscancer/views/buttomNavigationBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungscancer/widgets/doctorsList.dart';
import 'package:lungscancer/widgets/hospitalActivities.dart';
class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  __MainViewState createState() => __MainViewState();
}

class __MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  static  List<Widget> _screens = [    Home(),      UploadImage(),    NotificationScreen(),    LogoutScreen(),  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 22,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_outlined, color: Colors.black54),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_outlined, color: Colors.black54),
            label: 'صورة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none, color: Colors.black54),
            label: 'تقرير',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.black54),
            label: 'تسجيل خروج',
          ),
        ],
      ),
      body: SafeArea(
        child: _screens.elementAt(_selectedIndex),
      ),
    );
  }
}



class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final userProvider= ref.watch(authUserProvider);
      return  Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  SizedBox(height: 10),

                  // User name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "مرحباً,",
                            style: TextStyle(color: Colors.black87, fontSize: 17),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                           userProvider.SingleUser.userName.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage("assets/images/doctor1.png"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  // How do you fill card
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 223, 200, 228),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/surgeon.png",
                          width: 90,
                          height: 100,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "كيف تشعر الآن?",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                "قم الأن بتعبئة بياناتك الصحية",
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: Container(
                                width: 150,
                                height: 35,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Center(
                                  child: Text(
                                    "أبدا رحلتك العلاجية",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Main column seperator
                  SizedBox(height: 20),

                  // Search bar par
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    height: 65,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(95, 179, 173, 173),
                        borderRadius: BorderRadius.circular(15.0)),
                    // width: 10,
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "تصفح أخر تساؤلات المرضى?",
                          style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),

                  // Main column seperator
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        HospitalActivities(
                          icon: "assets/images/clean.png",
                          imageName: "Dentist",
                        ),
                        HospitalActivities(
                          icon: "assets/images/knife.png",
                          imageName: "Surgeon",
                        ),
                        HospitalActivities(
                          icon: "assets/images/lungs.png",
                          imageName: "Therapy",
                        ),
                        HospitalActivities(
                          icon: "assets/images/hormones.png",
                          imageName: "Physiologist",
                        ),
                      ],
                    ),
                  ),

                  // Main column seperator
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الجديد عن امراض الرئة",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "تصفح اللآن",
                        style: TextStyle(color: Colors.black45, fontSize: 15),
                      ),
                    ],
                  ),

                  // Main seperator
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        DoctorList(
                          image: "assets/images/doctor1.png",
                          name: "إسراء",
                          post: "نصائح وإرشادات",
                          experience: 4,
                        ),
                        DoctorList(
                          image: "assets/images/doctor2.png",
                          name: "Tسارة",
                          post: "نصائح وإرشادات",
                          experience: 4,
                        ),
                        DoctorList(
                          image: "assets/images/doctor3.png",
                          name: "نجلاء",
                          post: "نصائح وإرشادات",
                          experience: 4,
                        ),
                        DoctorList(
                          image: "assets/images/doctor4.png",
                          name: "إسراء",
                          post: "نصائح وإرشادات",
                          experience: 4,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      );
    },


    );
  }
}
