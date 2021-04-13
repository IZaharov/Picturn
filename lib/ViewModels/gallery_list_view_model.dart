import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryListViewModel extends ChangeNotifier {
  List<AssetEntity> imageAssets = [];
  int _currentIndex;

  Future<void> fetchImageGalleryAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );
    _currentIndex = 0;

    imageAssets = recentAssets
        .where((element) => element.type == AssetType.image)
        .toList();
  }

  set currentIndex(int value) {
    this._currentIndex = value;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

  Future<void> saveImage(File file) async {
    return await PhotoManager.editor
        .saveImage(file.absolute.readAsBytesSync())
        .then((value) {
      imageAssets.insert(0, value);
      _currentIndex = 0;
    });
  }
}
