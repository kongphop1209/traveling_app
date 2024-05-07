// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:traveling_app/screens/coupon.dart';
import 'package:traveling_app/screens/flight_page.dart';
import 'package:traveling_app/screens/popular.dart';
import 'package:traveling_app/screens/setting_page.dart';
import 'package:traveling_app/services/username_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Background.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 15.w),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/user.png',
                                              width: 50.w,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Hello',
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Color.fromARGB(
                                                          255, 211, 211, 211)),
                                                ),
                                                UsernameShow(
                                                  textStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15.w),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Text('Notifications'),
                                                content: Text(
                                                    'You have 0 notifications'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.w,
                                                              vertical: 5.h),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.blue),
                                                      child: Text(
                                                        'OK',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10.w),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                213, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: const Icon(
                                            Icons.notifications_none_outlined,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SettingPage(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10.w),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                213, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: const Icon(
                                            Icons.settings,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 25.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 54, 54, 54)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                      fontSize: 13.5.sp,
                                      color: Color.fromARGB(255, 83, 83, 83),
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Column(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  height:
                                      MediaQuery.of(context).size.height * 0.19,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(223, 26, 26, 26)),
                                    color: const Color.fromARGB(80, 0, 0, 0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 15.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const FlightPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      child: Image.asset(
                                        'assets/images/flight.png',
                                        width: 60.w,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PopularPage(),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/popular.png',
                                      width: 60.w,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CouponPage(),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/coupon.png',
                                      width: 60.w,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FlightPage(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              'Book New Tickets',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Deal 🔥',
                            style: TextStyle(
                                fontSize: 13.5.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'View all',
                            style: TextStyle(
                                fontSize: 12.5.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: EdgeInsets.only(left: 20.w),
                          child: Row(
                            children: [
                              Image.asset('assets/images/Banner.png'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Image.asset('assets/images/Banner_1.png'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Image.asset('assets/images/Banner.png'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Image.asset('assets/images/Banner_1.png'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Disable Android back button press
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _disableBackButtonAndroid(context);
    });
  }

  void _disableBackButtonAndroid(BuildContext context) {
    // Disable the Android back button for navigating back to the login page
    ModalRoute.of(context)?.removeScopedWillPopCallback(_onWillPop);
    ModalRoute.of(context)?.addScopedWillPopCallback(_onWillPop);
  }

  Future<bool> _onWillPop() async {
    // Check if you're on the login page
    if (ModalRoute.of(context)?.settings.name == "/login") {
      // If on the login page, exit the app
      return true;
    } else {
      // Otherwise, pop until you reach the login page
      Navigator.popUntil(context, ModalRoute.withName("/login"));
      return false;
    }
  }
}
