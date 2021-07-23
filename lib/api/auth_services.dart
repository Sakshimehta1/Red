import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:red/model/user.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
   FirebaseFirestore db = FirebaseFirestore.instance;
   String UID;
  CollectionReference usersColl;
  DocumentReference documentReference;
  Stream<User> get UserStream {
    return _auth.authStateChanges();
  }

  Future<User> registerUser(String email, String password,BuildContext context) async {
    try {
      UserCredential authresult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user=authresult.user;
      await initialize();
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        VxToast.show(context,msg:'The password provided is too weak.',bgColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        VxToast.show(context,msg:'The account already exists for that email.',bgColor: Colors.red);
      }
      else
        {
          VxToast.show(context,msg:e.message,bgColor: Colors.red);
        }
      return null;
    } catch (e) {
      print(e.toString());
      VxToast.show(context,msg:'The password provided is too weak.',bgColor: Colors.red);
    }

  }

  Future saveDatatoFirebase(Map<String,dynamic> data)
  async {
    await initialize();
    await documentReference.set(data).onError((error, stackTrace) => print(error+"Errrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrr")).
    then((value) => print("Reallyyyyyyyyyyy saved"));
  }

  Future logout()
  {
    _auth.signOut();
  }
  Future<dynamic> getData() async {
    var data;
    await initialize();
    await documentReference.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      data=snapshot.data();
      return snapshot;
    });
    return data;
  }
  Future login(String email,String password)
  async {
    var errorlog;
   await _auth.signInWithEmailAndPassword(email: email, password: password).
   then((value) =>
       print(value))
       .onError((error, stackTrace)
       {
            print("vvvvvvvvvvvvvvvv");
            errorlog=error.toString();
            Fluttertoast.showToast(msg: errorlog,backgroundColor: Colors.red,gravity: ToastGravity.SNACKBAR);
       }
   );
  }

  Future addPatient(Map<String,dynamic> data)
  async {
    await initialize();
    await db.collection("patients").doc(UID).set(data).onError((error, stackTrace) => print(error+"Errrrrrrrrrrrrrrrrrorrrrrrrrrrrrrrrr")).
    then((value) => print("Reallyyyyyyyyyyy saved"));
  }
  Future<void> initialize()
  async {
    UID=await _auth.currentUser.uid;
    documentReference= await db.collection('users').doc(UID);
  }

  Future uploadPhotoFirebase(File imgfile)
  async {
    await initialize();
    String imageURL = await uploadFile(imgfile);
    print("dddddddddddddddddddddddd"+imageURL);
    String result;
    await documentReference.update({"image": imageURL}).then(
            (value) => result="Success")
    .onError((error, stackTrace) => result=error.toString());
    return result;
  }

  Future<String> uploadFile(File imgfile)
  async {
    String downloadUrl;
    String imageName = path.basename(imgfile.path);
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('photos/$imageName');
    TaskSnapshot snapshot = await storageReference.putFile(imgfile);
    if (snapshot.state == TaskState.success) {
      downloadUrl =
      await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else if(snapshot.state==TaskState.error){
      print(
          'Error from image repo ${snapshot.state.toString()}');
      throw ('This file is not an image');
    }
  }
//  Future
}
//  Widget Image()
//  {
//    data['image'][0] != null)?ClipOval(
//  child: Image.network(
//  data['image'][0],
//  width: context.percentHeight*20,
//  height: context.percentHeight*20,
//  fit: BoxFit.fill,
//  ),
//  ):CircleAvatar(
//  backgroundImage: AssetImage('assets/avimg.png'),
//  radius: context.percentHeight*10,
//  )
//    return (data['image'][0] != null)
//        ? NetworkImage(data['image'][0]):AssetImage('assets/avimg.png');;
//  }