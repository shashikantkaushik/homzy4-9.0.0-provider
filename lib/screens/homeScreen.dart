import 'package:flutter/material.dart';
import 'package:homzy1/screens/request_screen.dart';
import 'package:homzy1/screens/setting_page.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Service Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Service Provider'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Container(
        color: Colors.grey[200],
          height: 100,
          child: const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Good Morning Partner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
          const SizedBox(
            height: 80,
          ),

          // Row(
          //     children: [
          //       Expanded(
          //         child:Container(
          //           padding: EdgeInsets.all(16.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               CircleAvatar(
          //                 radius: 30.0,
          //                 child: Icon(Icons.attach_money, size: 35.0, color: Colors.white),
          //                 backgroundColor: Colors.green,
          //               ),
          //               // SizedBox(height: 16.0),
          //               // Text(
          //               //   '60',
          //               //   style: TextStyle(
          //               //     color: Colors.green,
          //               //     fontSize: 24.0,
          //               //     fontWeight: FontWeight.bold,
          //               //   ),
          //               // ),
          //               SizedBox(height: 40.0),
          //               Text(
          //                 'Pending Request',
          //                 style: TextStyle(
          //                   fontSize: 16.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           padding: EdgeInsets.all(16.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               CircleAvatar(
          //                 radius: 30.0,
          //                 child: Icon(Icons.attach_money, size: 35.0, color: Colors.white),
          //                 backgroundColor: Colors.blue,
          //               ),
          //               SizedBox(height: 16.0),
          //               Text(
          //                 '40',
          //                 style: TextStyle(
          //                   color: Colors.blueAccent,
          //                   fontSize: 24.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               SizedBox(height: 8.0),
          //               Text(
          //                 'Order Reviced',
          //                 style: TextStyle(
          //                   fontSize: 16.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
            const SizedBox(
              height: 80,
            ),
            Row(
              children: [
                Expanded(
                  child:Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.attach_money, size: 35.0, color: Colors.white),
                        ),
                        // SizedBox(height: 16.0),
                        // Text(
                        //   '60',
                        //   style: TextStyle(
                        //     color: Colors.green,
                        //     fontSize: 24.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        SizedBox(height: 40.0),
                        Text(
                          'Pending Request',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.attach_money, size: 35.0, color: Colors.white),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          '40',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Order Reviced',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
                MaterialPageRoute(builder: (context) => const SubSetting()),
              );
              break;
          }
        },
      ),

    );
  }
}
