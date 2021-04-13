import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/camera_view_model.dart';
import 'package:picturn/ViewModels/gallery_list_view_model.dart';
import 'package:provider/provider.dart';

import '../gallery_view.dart';

class ProfilePhotoEditView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePhotoEditView();
  }
}

class _ProfilePhotoEditView extends State<ProfilePhotoEditView> {
  GalleryListViewModel _galleryListViewModel;
  CameraViewModel _cameraViewModel;

  @override
  void initState() {
    _initialise();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Изменение аватара',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ChangeNotifierProvider(
        create: (context) => _galleryListViewModel,
        child: GalleryView(
            _cameraViewModel, _galleryListViewModel, () => _editPhoto(context)),
      ),
    );
  }

  void _initialise() {
    _galleryListViewModel = GalleryListViewModel();
    _cameraViewModel = CameraViewModel();
    _galleryListViewModel
        .fetchImageGalleryAssets()
        .then((value) => setState(() {}));
  }

  void _editPhoto(BuildContext context) {
    print('photo 123123');
    Navigator.pop(context);
  }
}
