import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxseek_v1/src/controllers/auth_controller.dart';

class ImageController {
  static void initialize() {
    GetIt.instance.registerSingleton<ImageController>(ImageController());
  }

  // Static getter to access the instance through GetIt
  static ImageController get instance => GetIt.instance<ImageController>();

  static ImageController get I => GetIt.instance<ImageController>();

  final FirebaseStorage dbStorage = FirebaseStorage.instance;

  final ImagePicker imagePicker = ImagePicker();

  // para mo get og imgae using camera
  captureImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return await image.readAsBytes();
    }
    print("No image is captured");
  }

  // pra mo select images sa gallery
  selectImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return await image.readAsBytes();
    }
    print("No image is selected");
  }

  uploadImageProfileToDb(Uint8List imageFile, String childName) async {
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
}
