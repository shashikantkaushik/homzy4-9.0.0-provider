
import 'package:flutter/material.dart';
import 'package:homzy1/screens/homeScreen.dart';
import 'package:homzy1/screens/respose.dart';
import 'package:homzy1/auth.dart';
import 'package:homzy1/req_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRequest extends StatefulWidget {
  const ServiceRequest({Key? key}) : super(key: key);


  @override
  _ServiceRequestState createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {
  late FirebaseFirestore _firebaseFirestore;

  @override
  void initState() {
    super.initState();
    _firebaseFirestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {

    final ap = Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.teal,
        //Color(0xFF189AB4),
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_sharp,
          color: Colors.white,),
        ),

        title: const Text('Service Requests',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firebaseFirestore.collection("request").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          print("sdg23hfd");
          List<ReqModel> reqList = [];
          for (final docSnapshot in snapshot.data!.docs) {
            print("s34dghfd");
            final data = docSnapshot.data();
            final reqModel = ReqModel.fromMap(data);
            reqList.add(reqModel);

          }
print(reqList.length);
          return ListView.builder(
            itemCount: reqList.length,
            itemBuilder: (context, index) {
              var name=reqList[index].userName;
              var address=reqList[index].address;
              var pic=reqList[index].userPic;
              var work=reqList[index].work;
              var price=reqList[index].price;
              return Container(
                child: ListView(
                    shrinkWrap:true,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RequestScreen(MyUID: index)),
                        );
                        // Navigate to detail screen for request 2
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage('$pic'),
                        ),
                        title: Text('$work', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        subtitle: Text('$price' , style: TextStyle(color: Colors.black),),
                        trailing: Icon(Icons.arrow_forward),
                      ),
                    ),
                    Divider(
                      thickness: 0.2,
                      height: 2,
                      indent: 25,
                      endIndent: 25,
                      color: Colors.grey,
                    ),
                    // Add more list items as needed
                  ],
                ),
              );

            },
          );
        },
      ),
    );
  }
}
