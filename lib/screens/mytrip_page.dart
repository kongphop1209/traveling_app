import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveling_app/models/ticket_model.dart';
import 'package:traveling_app/screens/setting_page.dart';
import 'package:traveling_app/services/username_widget.dart';

class MyTripPage extends StatefulWidget {
  const MyTripPage({Key? key}) : super(key: key);

  @override
  State<MyTripPage> createState() => _MyTripPageState();
}

class _MyTripPageState extends State<MyTripPage> {
  final FirebaseService _firebaseService = FirebaseService();
  late String airline = '';
  late String duration = '';
  late String price = '';
  late String time = '';
  late String username = '';

  @override
  void initState() {
    super.initState();
    _fetchFlightData();
    _fetchUsername();
  }

  Future<void> _fetchFlightData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        DocumentSnapshot flightSnapshot = await FirebaseFirestore.instance
            .collection('user_flights_$userId')
            .doc('booking')
            .get();

        setState(() {
          airline = flightSnapshot['airline'] ?? '';
          duration = flightSnapshot['duration'] ?? '';
          price = flightSnapshot['price'] ?? '';
          time = flightSnapshot['time'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching flight data: $e');
    }
  }

  Future<void> _fetchUsername() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          username = userSnapshot['username'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching username: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasFlightData = airline.isNotEmpty;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/user.png',
                          width: 50.w,
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UsernameShow(
                              textStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 15.sp,
                                  color: Colors.red,
                                ),
                                Text(
                                  'Chiang Rai - CEI',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: Color.fromARGB(255, 61, 61, 61),
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 25.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Text(
                  'Flight Details',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Container(
                  child: hasFlightData
                      ? Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.blue,
                                    Color.fromARGB(255, 170, 245, 255),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  _buildFlightInfoItem('Airline', airline),
                                  _buildFlightInfoItem('Duration', duration),
                                  _buildFlightInfoItem('Price', price),
                                  _buildFlightInfoItem('Time', time),
                                ],
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 224, 15, 0)),
                              child: Text(''),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _firebaseService
                                        .removeBookingFromFirestore(
                                      FirebaseAuth.instance.currentUser!.uid,
                                    )
                                        .then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Flight removed successfully'),
                                        ),
                                      );
                                    }).catchError((error) {
                                      print('Error removing flight: $error');
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  child: Text(
                                    'Remove Flight',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            'No flight yet',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 63, 4),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlightInfoItem(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 88, 88, 88),
            ),
          ),
        ],
      ),
    );
  }
}
