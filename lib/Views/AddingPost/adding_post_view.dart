import 'dart:io';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picturn/Models/post.dart';
import 'package:picturn/Models/profile.dart';
import 'package:picturn/ViewModels/adding_post_view_model.dart';
import 'package:picturn/ViewModels/camera_view_model.dart';
import 'package:picturn/ViewModels/gallery_list_view_model.dart';
import 'package:picturn/ViewModels/post_list_view_model.dart';
import 'package:picturn/ViewModels/post_view_model.dart';
import 'package:picturn/Views/AddingPost/full_size_image_asset_view.dart';
import 'package:picturn/Views/AddingPost/image_asset_gallery_view.dart';
import 'package:picturn/Views/CustomWidgets/stroke_text.dart';
import 'package:picturn/Views/gallery_view.dart';
import 'package:picturn/Views/navigation_bar_view.dart';
import 'package:provider/provider.dart';

import 'adding_wait_view.dart';

class AddingPostView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddingPostView();
  }
}

class _AddingPostView extends State<AddingPostView> {
  GalleryListViewModel _galleryListViewModel;
  AddingPostViewModel _addingPostViewModel;
  CameraViewModel _cameraViewModel;
  bool _isAdding;

  @override
  void initState() {
    _initialise();
  }

  void _initialise() {
    _galleryListViewModel = GalleryListViewModel();
    _addingPostViewModel = AddingPostViewModel();
    _cameraViewModel = CameraViewModel();
    _isAdding = false;
    _galleryListViewModel
        .fetchImageGalleryAssets()
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return _isAdding
        ? AddingWaitView(height)
        : ChangeNotifierProvider(
            create: (context) => _galleryListViewModel,
            child: GalleryView(_cameraViewModel, _galleryListViewModel, () => _addPost(context)),
          );
  }

  void _addPost(BuildContext context) {
    print('add post');
    _galleryListViewModel.imageAssets[_galleryListViewModel.currentIndex].file
        .then((value) {
      _addingPostViewModel.addPost(value).then((value) {
        setState(() {
          _initialise();
        });
        var navigationBarViewModel =
            Provider.of<NavigationBarViewModel>(context, listen: false);
        navigationBarViewModel.currentIndex = 2;

        _refreshUserProfilePostList(context);
      });

      //loading animation
      setState(() {
        _isAdding = true;
      });
    });
  }

  void _refreshUserProfilePostList(BuildContext context) {
    var profilePostListViewModel =
        Provider.of<PostListViewModel>(context, listen: false);
    profilePostListViewModel.refreshPosts();
  }
}
