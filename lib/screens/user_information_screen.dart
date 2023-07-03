import 'dart:io';
import 'package:homzy1/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:homzy1/user_model.dart';
import 'package:homzy1/auth.dart';
import 'package:homzy1/screens/homeScreen.dart';
import 'package:homzy1/utils.dart';
import 'package:homzy1/widget/button.dart';
import 'package:provider/provider.dart';
class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final upiController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
    upiController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        )
            : SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () => selectImage(),
                  child: image == null
                      ? const CircleAvatar(
                    backgroundColor:Color(0xFFC5C6d0),
                    radius: 80,
                    backgroundImage: AssetImage('assets/1.1.jpeg'),
                  )
                      : CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 80,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      // name field
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(

                        decoration: const InputDecoration(
                          hintText: "Enter Your Name",
                          icon: Icon(Icons.account_box_rounded, color: Color(0xFFC5C6d0),
                              size: 30),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // email
                      TextField(
                        decoration: const InputDecoration(
                          hintText: "abc@example.com",
                          icon: Icon(Icons.alternate_email, color: Color(0xFFC5C6d0),
                              size: 30),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // bio

                      TextField(
                        decoration: const InputDecoration(
                          hintText: "Enter Your UPI Here",
                          icon: Icon(Icons.edit, color: Color(0xFFC5C6d0),
                              size: 30),
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        controller: upiController,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: CustomButton(
                    text: "Continue",
                    onPressed: () => storeData(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: const Color(0xFF189AB4),
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xfff1f5f5ff),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,

        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      upi: upiController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",

    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ProviderModel providerModel =  ProviderModel(
             income:0,

             order: 0,
            phoneNumber: '',
            uid: '',

          );

          // ap.saveProDataToFirebase(context: context, providerModel: providerModel);
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                  (value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>   const HomeScreen(),
                  ),
                      (route) => false),
            ),
          );
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
}
