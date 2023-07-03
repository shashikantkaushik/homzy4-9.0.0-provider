// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:homzy1/auth.dart';
// import 'package:provider/provider.dart';
//
// class EditProfile extends StatefulWidget {
//   const EditProfile({Key? key}) : super(key: key);
//
//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   @override
//   bool isUpisecrePassword =true;
//   Widget build(BuildContext context) {
//     final ap = Provider.of<AuthProvider>(context, listen: false);
//     final name=(ap.userModel.name);
//     final email=(ap.userModel.email);
//
//     final phone=(ap.userModel.phoneNumber);
//     final pic=(ap.userModel.profilePic);
//     final uid=(ap.userModel.uid);
//     final date=(ap.userModel.createdAt);
//     // final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('messages');
//     final t = (ap.userModel.name);
//     return Scaffold(
//       appBar: AppBar(
//         title:Text('Edit Profile',style: TextStyle(fontSize: 22,color: Colors.black87)),
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.settings,
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: 15,top: 20,right: 15),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: ListView(
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           border: Border.all(width: 4,color: Colors.white),
//                           boxShadow: [
//                             BoxShadow(
//                               spreadRadius: 2,
//                               blurRadius: 10,
//                               color: Colors.black.withOpacity(0.1),
//                             )
//                           ],
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage('$pic'),
//
//                           )
//                       ),
//                     ),
//                     Positioned(
//                       bottom:0,
//                       right: 0,
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                             color: Colors.blue,
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               width: 4,
//                               color: Colors.white,
//                             )
//                         ),
//                         child: Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30,),
//               buildTextField("Full Name","$name", false),
//               buildTextField("Email", "$email", false),
//               buildTextField("Location","India",false),
//
//               SizedBox(height: 30,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutlinedButton(onPressed: () {
//                     Navigator.pop(context);
//                   }, child:Text("Cancel",style: TextStyle(
//                     fontSize: 15,
//                     letterSpacing: 2,
//                     color: Colors.black,
//                   ),),
//                     style: OutlinedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(horizontal: 50),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
//                     ),
//                   ),
//                   ElevatedButton(onPressed: () {},
//                     child: Text("Save",style: TextStyle(
//                         fontSize: 15,
//                         letterSpacing: 2,
//                         color: Colors.white
//                     ),),
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.blue,
//                         padding: EdgeInsets.symmetric(horizontal: 50),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
//                     ),
//                   )
//
//                 ],
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget buildTextField(String labelText,String placeholder,bool isUpiTectField){
//     return Padding(padding: EdgeInsets.only(bottom: 30),
//       child: TextField(
//         style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
//         obscureText: isUpiTectField ? isUpisecrePassword:false,
//         decoration: InputDecoration(
//
//           //suffixIcon: isUpiTectField?
//           // IconButton(
//           //     onPressed: () {}, icon: Icon(Icons.remove_red_eye,color: Colors.grey,),
//           // ): null,
//             contentPadding: EdgeInsets.only(bottom: 5),
//             labelText: labelText,
//
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             hintText: placeholder,
//             hintStyle: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             )
//         ),
//       ),
//     );
//   }
// }