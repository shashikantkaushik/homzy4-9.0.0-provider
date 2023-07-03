




import 'package:flutter/material.dart';
import 'package:homzy1/auth.dart';
import 'package:provider/provider.dart';
import 'package:homzy1/screens/WelcomeScreen.dart';
class SubSetting extends StatefulWidget {
  const SubSetting({super.key});

  @override
  State<SubSetting> createState() => _SubSettingState();
}

class _SubSettingState extends State<SubSetting> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    const kchatbot="24b188427eb21cddb27882c3ee1ffae54";
    final name=(ap.userModel.name);
    final email=(ap.userModel.email);
    final bio=(ap.userModel.upi);
    final phone=(ap.userModel.phoneNumber);
    final pic=(ap.userModel.profilePic);
    final uid=(ap.userModel.uid);
    final date=(ap.userModel.createdAt);
    // final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('messages');
    final t = (ap.userModel.name);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Circular, small image in the middle of the top screen
            SafeArea(

              child: Container(

                child:Padding(
                    padding: EdgeInsets.only(top: 20),
                    child:

                    CircleAvatar(

                      backgroundImage: NetworkImage(ap.userModel.profilePic ?? 'https:pfoile.com'),
                      backgroundColor: const Color(0xFF189AB4),
                      radius: 50,
                    )
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Container 1 with payment icon and arrow
            Container(
              height: 60.0,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 32.0,
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        "Profile Edit",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 60.0,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.payment,
                        color: Colors.black,
                        size: 32.0,
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        "Payment",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 60.0,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.question_answer,
                        color: Colors.black,
                        size: 32.0,
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        "FAQ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Container 2
            Container(
              height: 60.0,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.help,
                        color: Colors.black,
                        size: 32.0,
                      ),
                      const SizedBox(width: 16.0),
                      TextButton(
                        onPressed: (){
                          // dynamic conversationObject = {
                          //   'appId': '$kchatbot',// The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                          // };
                          //
                          // KommunicateFlutterPlugin.buildConversation(conversationObject)
                          //     .then((clientConversationId) {
                          //
                          //   print("Conversation builder success : " + clientConversationId.toString());
                          // }).catchError((error) {
                          //   print("Conversation builder error : " + error.toString());
                          // });
                        },
                        child: const Text(
                          "Help",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),
            // Container 3
            // Container 4
            // Container 4
            Container(
              height: 60.0,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.email,
                        color: Colors.black,
                        size: 32.0,
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        "About us",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Container 3
            // Container 4
            Container(
              height: 60.0,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      ap.userSignOut().then(
                            (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            ap.userSignOut().then(
                                  (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.logout,
                            color: Colors.black,
                            size: 32.0,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: (){
                            print("press");
                            ap.userSignOut().then(
                                  (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WelcomeScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){
                      ap.userSignOut().then(
                            (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                              (Route<dynamic> route) => false,
                        ),
                      );

                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Container 5
          ],
        ),
      ),
    );
  }
}
