import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class ImageController {
  static void initialize() {
    GetIt.instance.registerSingleton<ImageController>(ImageController());
  }

  // Static getter to access the instance through GetIt
  static ImageController get instance => GetIt.instance<ImageController>();

  static ImageController get I => GetIt.instance<ImageController>();

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
}
