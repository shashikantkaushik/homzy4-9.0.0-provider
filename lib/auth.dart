import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homzy1/booked_model.dart';
import 'package:homzy1/provider_model.dart';
import 'package:homzy1/req_model.dart';
import 'package:homzy1/screens/request_screen.dart';
import 'package:homzy1/utils.dart';
import 'package:flutter/material.dart';
import 'package:homzy1/user_model.dart';
import 'package:homzy1/screens/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';






class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? _uid;

  BookModel? _bookModel;
  BookModel get bookModel => _bookModel!;

  ProviderModel? _providerModel;
  ProviderModel get providerModel => _providerModel!;


  String get uid => _uid!;
  UserModel? _userModel;


  UserModel get userModel => _userModel!;
  ReqModel? _reqModel;

  ReqModel get reqModel => _reqModel!;
  String? _verificationId;

  String get verificationId => _verificationId!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // signin
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            _verificationId = verificationId;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId,),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  //resend otp

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        name: snapshot['name'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        upi: snapshot['upi'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
      );
      _uid = userModel.uid;
    });
  }

  // STORING DATA LOCALLY
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }


  void resendOTP(BuildContext context, String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (newVerificationId, forceResendingToken) {
          _verificationId = newVerificationId;
          showSnackBar(context, 'OTP sent again');
        },
        codeAutoRetrievalTimeout: (verificationId) {}
    );
  }

  // Future getReqFromFirestore() async {
  //   await _firebaseFirestore
  //       .collection("request")
  //       .doc(_firebaseAuth.currentUser!.uid)
  //       .get()
  //       .then((DocumentSnapshot snapshot) {
  //     _reqModel = ReqModel(
  //       name: snapshot['name'],
  //       createdAt: snapshot['createdAt'],
  //       bio: snapshot['bio'],
  //       uid: snapshot['uid'],
  //       reqPic: snapshot['profilePic'],
  //       phoneNumber: snapshot['phoneNumber'],
  //     );
  //     _uid = reqModel.uid;
  //   });
  // }

  // Future<List<ReqModel>> getReqListFromFirestore() async {
  //   List<ReqModel> reqList = [];
  //
  //   await _firebaseFirestore
  //       .collection("request")
  //       .get()
  //       .then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       ReqModel reqModel = ReqModel(
  //         name: doc['name'],
  //         createdAt: doc['createdAt'],
  //         bio: doc['bio'],
  //         uid: doc['uid'],
  //         reqPic: doc['profilePic'],
  //         phoneNumber: doc['phoneNumber'],
  //       );
  //       reqList.add(reqModel);
  //     });
  //   });
  //
  //   return reqList;
  // }

  void saveProDataToFirebase({
    required BuildContext context,
    required ProviderModel providerModel,

  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Increment the order variable by 1
      providerModel.order += 1;
      providerModel.income+=5;
      providerModel.uid=
      // Set the phone number and UID fields from the current user
      providerModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      providerModel.uid = _firebaseAuth.currentUser!.uid;

      // Upload to the database
      await _firebaseFirestore
          .collection("provider")
          .doc(providerModel.phoneNumber)
          .set(providerModel.toMap())
          .then((value) {

        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }


  void saveReqDataToFirebase({
    required BuildContext context,
    required ReqModel ReqModel,
    required File reqPic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("Pic/$_uid", reqPic).then((value) {
        reqModel.reqPic = value;
        reqModel.createdAt = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        reqModel.userPhoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        reqModel.userUid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _reqModel = reqModel;

      // uploading to database
      await _firebaseFirestore
          .collection("request")
          .doc(_uid)
          .set(reqModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<ReqModel>> getReqListFromFirestore() async {
    final querySnapshot = await _firebaseFirestore.collection("request").get();

    List<ReqModel> reqList = [];
    for (var doc in querySnapshot.docs) {
      ReqModel reqModel = ReqModel(
          pin: doc.data()['description'],
          price: doc.data()['price'],
          address: doc.data()['address'],
          userName: doc.data()['name'],
          work: doc.data()['work'],
          createdAt: doc.data()['createdAt'],
          desc: doc.data()['bio'],
          userUid: doc.data()['uid'],
          reqPic: doc.data()['profilePic'],
          userPhoneNumber: doc.data()['phoneNumber'],
          userPic: doc.data()['userPic']
      );
      reqList.add(reqModel);
    }

    return reqList;
  }


  Future getProviderData() async {
    await _firebaseFirestore
        .collection("provider")
        .doc()
        .get()
        .then((DocumentSnapshot snapshot) {
      _providerModel = ProviderModel(
        income: snapshot['income'],
        order: snapshot['order'],
        uid: snapshot['uid'],

        phoneNumber: snapshot['phoneNumber'],
      );
      _uid = providerModel.uid;
    });
  }


  void saveBookReq({
    required BuildContext context,
    required BookModel bookModel,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      print("hlo11");
     // bookModel.acceptedAt = DateTime.now().millisecondsSinceEpoch.toString();
     //  bookModel.proPhoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
     //  bookModel.proUid = _firebaseAuth.currentUser!.phoneNumber!;
     //  bookModel.upi=userModel.upi;
     //  bookModel.proPic=userModel.profilePic;
     //  bookModel.userUid=reqModel.userUid;
     //  bookModel.userName=reqModel.userName;
     //  bookModel.userPhoneNumber=reqModel.userPhoneNumber;
     // bookModel.createdAt=reqModel.createdAt;
     //  bookModel.reqPic=reqModel.reqPic!;
     //  bookModel.desc=reqModel.desc;
      _bookModel = bookModel;
      print("hlo131");

      // uploading to database
      await _firebaseFirestore
          .collection("book")
          .doc(bookModel.userPhoneNumber)
          .set(bookModel.toMap())
          .then((value) {
        onSuccess(){
          print("hlo132331");
        }
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      print("5677675");
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void move1(String phoneNumber,context) async {
    final sourceCollection = FirebaseFirestore.instance.collection('request');
;

      // Delete the document from the source collection
      await sourceCollection.doc(phoneNumber).delete();
      print('Document with phone number $phoneNumber moved successfully!');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServiceRequest()),
      );

    

  }

  //
  void move2(String phoneNumber,context) async {
    final sourceCollection = FirebaseFirestore.instance.collection('book');
    final destinationCollection = FirebaseFirestore.instance.collection(
        'moved');

    final sourceDocSnapshot = await sourceCollection.doc(phoneNumber).get();

    if (sourceDocSnapshot.exists) {
      final sourceDocData = sourceDocSnapshot.data();

      // Add the document to the destination collection with phone number as document ID
      await destinationCollection.doc(phoneNumber).set(sourceDocData!);

      // Delete the document from the source collection
      await sourceCollection.doc(phoneNumber).delete();
      print('Document with phone number $phoneNumber moved successfully!');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServiceRequest()),
      );

    } else {
      print(
          'Document with phone number $phoneNumber does not exist in the request collection!');
    }
  }

  //
  // void deleteRequestByUID(String MyUID) {
  //   // Get a reference to the request collection in Firestore
  //   final CollectionReference requestRef =
  //   FirebaseFirestore.instance.collection('request');
  //
  //   // Use the MyUID parameter to build a query to find the document to delete
  //   final Query query = requestRef.where('MyUID', isEqualTo: MyUID);
  //
  //   // Use the query to get a reference to the document to delete
  //   query.get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       // Delete the document
  //       doc.reference.delete().then((_) {
  //         print('Document successfully deleted!');
  //       }).catchError((error) {
  //         print('Error removing document: $error');
  //       });
  //     });
  //   }).catchError((error) {
  //     print('Error getting document: $error');
  //   });
  // }
  //
  //





// Delete the document from the source collectio


/*
checkSign(): A method that checks whether the user is signed in or not by accessing shared preferences.
setSignIn(): A method that sets the _isSignedIn property to true and saves this value to shared preferences.
signInWithPhone(): A method that initiates the phone number verification process with Firebase.
verifyOtp(): A method that verifies the OTP entered by the user during the phone number verification process.
checkExistingUser(): A method that checks whether the user already exists in the database.
saveUserDataToFirebase(): A method that saves the user data to Firebase.
storeFileToStorage(): A method that uploads a file to Firebase Storage.
getDataFromFirestore(): A method that retrieves the user data from Firestore.
saveUserDataToSP(): A method that saves the user data to shared preferences.
getDataFromSP(): A method that retrieves the user data from shared preferences.
userSignOut(): A method that signs the user out.



user already exist
_firebaseFirestore is a reference to an instance of the Firestore database.

collection("users") returns a reference to the "users" collection in the database.

doc(_uid) returns a reference to the document with the ID _uid in the "users" collection.

get() retrieves the document from the database and returns a DocumentSnapshot object.

if (snapshot.exists) checks if the document exists in the database. If it exists, the function returns true, indicating that the user already exists in the database. Otherwise, the function returns false, indicating that the user is new.



Future<void> getReqFromFirestore() async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection("request")
        .where('name', isEqualTo: 'shashi')
        .get();
    if (snapshot.size > 0) {
      final data = snapshot.docs.first.data();
      _reqModel = ReqModel(
        name: data['name'],
        createdAt: data['createdAt'],
        bio: data['bio'],
        uid: data['uid'],
        reqPic: data['profilePic'],
        phoneNumber: data['phoneNumber'],
      );
      _uid = _reqModel.uid;
    } else {
      // handle case where no documents match the query
    }
  } catch (e) {
    // handle error
  }
}
Here's a summary of the changes:

Added async and await to make the code cleaner and easier to read.
Added a try-catch block to handle errors that may occur during the query.
Changed then to await to wait for the query to finish before processing the results.
Added a check to make sure the query returned at least one document.
Changed snapshot to snapshot.docs.first.data() to access the data of the first document that matched the query.
Added _ to _reqModel.uid to make it clear that _reqModel is an instance variable.
Added comments to explain what the code does and to indicate where to handle errors and edge cases.



Shashi Kant
i want to access data of all document to match this query
To access the data of all documents that match a query, you can use the QuerySnapshot class instead of DocumentSnapshot. The get() method of a query returns a QuerySnapshot containing all the documents that match the query. You can then loop through the documents in the snapshot and access their data using the data() method. Here's an example:

php
Copy code
Future<List<ReqModel>> getReqListFromFirestore() async {
  final querySnapshot = await _firebaseFirestore
      .collection("request")
      .where('name', isEqualTo: 'shashi')
      .get();

  List<ReqModel> reqList = [];

  querySnapshot.docs.forEach((doc) {
    ReqModel reqModel = ReqModel(
      name: doc['name'],
      createdAt: doc['createdAt'],
      bio: doc['bio'],
      uid: doc['uid'],
      reqPic: doc['profilePic'],
      phoneNumber: doc['phoneNumber'],
    );
    reqList.add(reqModel);
  });

  return reqList;
}
 */
}