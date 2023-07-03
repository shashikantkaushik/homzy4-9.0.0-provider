import 'package:flutter/material.dart';
import 'package:homzy1/screens/request_screen.dart';
import 'package:homzy1/screens/profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:homzy1/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:homzy1/screens/account_page.dart';
import 'package:lottie/lottie.dart';
void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late FirebaseFirestore _firebaseFirestore;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // @override
  // void initState() {
  //   print("init");
  //   super.initState();
  //   _firebaseFirestore = FirebaseFirestore.instance;
  //}
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return MaterialApp(
      title: 'Home Service Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String location ='Null, Press Button';

  late FirebaseFirestore _firebaseFirestore;

  String Address = 'Location';
  //String Address2= 'search';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.administrativeArea}';
    //Address2='${place.locality}';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getGeoLocationPosition()
        .then((position) => GetAddressFromLatLong(position));
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final name = (ap.userModel.name);
    final email = (ap.userModel.email);

    final phone = (ap.userModel.phoneNumber);
    final pic = (ap.userModel.profilePic);
    final uid = (ap.userModel.uid);
    final date = (ap.userModel.createdAt);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.5,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text("Homzy Provider",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )),
        actions: [
          GestureDetector(
            onTap: () {
              print("dlo");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            },
            child: Row(
                children:[  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 40, // adjust as needed
                      backgroundImage: NetworkImage('$pic'),
                      //foregroundImage: AssetImage('assets/robot.jpeg'), // placeholder image
                      // child: Icon(Icons.person, size: 40, color: Colors.white), // optional child icon
                    )

                ),
                  SizedBox(width: 10,)
                ]
            ),
          )
        ],
      ),
      body: Column(children: [
        SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 18,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: Text(
                          '$Address',
                          maxLines: null,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${DateTime.now().day} ${DateFormat('MMMM').format(DateTime.now())} ${DateTime.now().year}",
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "Hello ,$name",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 320,
                        width: 380,
                        child:Lottie.asset('assets/house.json')
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Account',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ServiceRequest()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubSetting()),
              );
              break;
          }
        },
      ),
    );
  }
}
