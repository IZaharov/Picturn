import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetListViewModel extends ChangeNotifier {
  List<AssetEntity> assets = [];
  int _currentIndex;

  AssetListViewModel() {
    this.fetchAssets();
  }

  fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
        start: 0, // start at index 0
        end: 1000000); // end at a very big index (to get all the assets)

    this.assets = recentAssets;
    this.currentIndex = 0;
  }

  set currentIndex(int value) {
    this._currentIndex = value;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
}
