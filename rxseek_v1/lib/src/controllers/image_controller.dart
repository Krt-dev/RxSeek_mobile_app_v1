import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';
import 'package:rxseek_v1/src/controllers/message_controller.dart';
import 'package:rxseek_v1/src/models/message_model.dart';
import 'package:path/path.dart' as path;

class ImageController {
  static void initialize() {
    GetIt.instance.registerSingleton<ImageController>(ImageController());
  }

  // Static getter to access the instance through GetIt
  static ImageController get instance => GetIt.instance<ImageController>();

  static ImageController get I => GetIt.instance<ImageController>();

  final FirebaseStorage dbStorage = FirebaseStorage.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final ImagePicker imagePicker = ImagePicker();

  // para mo get og imgae using camera
//returns the path of the networkAddress of iamge and Imagepath to send in the backend
  openCameraAndUploadImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      //image path is use for sending the image to the backend
      String imagePath = image.path;
      Uint8List img = await image.readAsBytes();
      String userId = AuthController.I.currentUser!.uid;
      String imageNetworkUrl = await ImageController.I.uploadImageToDb(
          img, "${userId}/${Timestamp.now().millisecondsSinceEpoch}");
      return [imageNetworkUrl, imagePath, await image.readAsBytes()];
    } else {
      print("No image is selected");
    }
  }

  // pra mo select images sa gallery
  selectandSendImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      //image path is use for sending the image to the backend
      String imagePath = image.path;
      Uint8List img = await image.readAsBytes();
      String userId = AuthController.I.currentUser!.uid;
      String imageNetworkUrl = await ImageController.I.uploadImageToDb(
          img, "${userId}/${Timestamp.now().millisecondsSinceEpoch}");
      return [imageNetworkUrl, imagePath, await image.readAsBytes()];
    } else {
      print("No image is selected");
    }
  }

//para get sa message response sa ocr or image then i add lahus sa db ron mabutang sa UI
  //para get sa message response sa ocr or image then i add lahus sa db ron mabutang sa UI
  getOcrResponse(String imagePath, String threadId) async {
    try {
      File file = File(imagePath);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://10.0.2.2:8000/process_query/"),
      );

      request.files.add(http.MultipartFile.fromBytes(
          'image', file.readAsBytesSync(),
          filename: file.path.split('/').last,
          contentType: MediaType('image', file.path.split('.').last)));

      //send ang request sa babaw mao ni ang pag make nako sa request diri ang pag send na
      try {
        var response = await request.send();

        if (response.statusCode == 200) {
          var httpResponse = await http.Response.fromStream(response);

          var jsonResponse = jsonDecode(httpResponse.body);
          Message messageOcrResponse = Message(
              messageId: DateTime.now().millisecondsSinceEpoch,
              content: jsonResponse["response"],
              sender: "system",
              imageUrl: "",
              timeCreated: Timestamp.now());
          //diri pag make message object with contents sa response para ma add ang response digtos db

          try {
            MessageController.I.db
                .collection("Thread")
                .doc(threadId)
                .collection("Messages")
                .add(messageOcrResponse.toJson());
          } on FirebaseException catch (e) {
            print({e.toString()});
          }
        }
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print("failed to generate response:" + e.toString());
    }
  }

  // Future<String> openCameraAndUploadImage() async {
  //   Uint8List img = await ImageController.I.captureImage();
  //   String userId = AuthController.I.currentUser!.uid;
  //   String imageNetworkUrl = await ImageController.I.uploadImageToDb(
  //       img, "${userId}/${Timestamp.now().millisecondsSinceEpoch}");
  //   return imageNetworkUrl;
  // }

  //  Future<String> sendImage() async {
  //   Uint8List img = await ImageController.I.selectImage();
  //   String userId = AuthController.I.currentUser!.uid;
  //   String imageNetworkUrl = await ImageController.I.uploadImageToDb(
  //       img, "${userId}/${Timestamp.now().millisecondsSinceEpoch}");
  //   return imageNetworkUrl;
  // }

  uploadImageToDb(Uint8List imageFile, String childName) async {
    Reference _ref = dbStorage.ref().child(childName);
    UploadTask uploadTask = _ref.putData(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String imageDownloadUrl = await snapshot.ref.getDownloadURL();

    return imageDownloadUrl;
  }

  Future<void> updateUserProfileUrl(String downloadedUrl, String userId) async {
    try {
      AuthController.I.db
          .collection("Users")
          .doc(userId)
          .update({"profileUrl": downloadedUrl});
    } on FirebaseException catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  streamProfileChange(String userId) async {
    try {
      return db.collection("Users").doc(userId).snapshots();
    } on FirebaseException catch (e) {
      print({e.toString()});
      return const Stream.empty();
    }
  }
}
