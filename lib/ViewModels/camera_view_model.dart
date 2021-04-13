import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CameraViewModel {
  Future<File> getImageFromCamera() async {
    PickedFile imageFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 100);
    return File(imageFile.path);
  }
}
