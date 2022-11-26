import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorgeMethods{
  FirebaseStorage storage=FirebaseStorage.instance;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

Future<String>uploadImageToFireStorge(String Namechild,Uint8List file,bool isposted)async
{
  Reference reference=storage.ref().child(Namechild).child(firebaseAuth.currentUser!.uid);
  UploadTask uploadTask=reference.putData(file);
      TaskSnapshot snapshot=  await  uploadTask;
 String getDownloaded= await snapshot.ref.getDownloadURL();
return getDownloaded;
}}