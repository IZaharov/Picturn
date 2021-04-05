import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageProvider {
  final firebaseStorageReference =
      firebase_storage.FirebaseStorage.instance.ref();

  Future<String> getImagePath(String id) async {
    return await firebaseStorageReference
        .child('images/${id}')
        .getDownloadURL();
  }

  Future uploadImageInStorage(File img, String id) async {
    await this.firebaseStorageReference.child('images/${id}').putFile(img);
  }
}
