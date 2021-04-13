import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/camera_view_model.dart';
import 'package:picturn/ViewModels/gallery_list_view_model.dart';

import 'AddingPost/full_size_image_asset_view.dart';
import 'AddingPost/image_asset_gallery_view.dart';
import 'CustomWidgets/stroke_text.dart';

class GalleryView extends StatefulWidget {
  CameraViewModel _cameraViewModel;
  GalleryListViewModel _galleryListViewModel;
  Function onSendImage;

  GalleryView(this._cameraViewModel, this._galleryListViewModel,this.onSendImage);

  @override
  State<StatefulWidget> createState() {
    return _GalleryView(_cameraViewModel, _galleryListViewModel, onSendImage);
  }
}

class _GalleryView extends State<GalleryView> {
  CameraViewModel _cameraViewModel;
  GalleryListViewModel _galleryListViewModel;
  Function onSendImage;

  _GalleryView(this._cameraViewModel, this._galleryListViewModel, this.onSendImage);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.5 - 50),
          child: FullSizeImageAssetView(),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, height * 0.5 - 50, 0, 0),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StrokeText('Галерея',
                  strokeColor: Colors.black,
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                  strokeWidth: 0.5),
              Material(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      icon: Icon(Icons.camera_alt),
                      iconSize: 30,
                      onPressed: () {
                        print('camera');
                        _cameraViewModel.getImageFromCamera().then((value) =>
                            _galleryListViewModel
                                .saveImage(value)
                                .then((value) => setState(() {})));
                      },
                    ),
                    IconButton(
                      splashRadius: 20,
                      icon: Icon(Icons.arrow_upward),
                      iconSize: 30,
                      onPressed: () => onSendImage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, height * 0.5, 0, 0),
          child: ImageAssetGalleryView(),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, height * 0.5 - 50, 0, 0),
          child: Divider(
            thickness: 2,
            height: 0,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, height * 0.5, 0, 0),
          child: Divider(
            thickness: 2,
            height: 0,
          ),
        ),
      ],
    );
  }
}
