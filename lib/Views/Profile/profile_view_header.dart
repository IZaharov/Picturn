import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';
import 'package:picturn/Views/Profile/profile_exit_button.dart';
import 'package:picturn/Views/Profile/profile_title_view.dart';

import 'profile_photo_edit_button.dart';

class ProfileViewHeader implements SliverPersistentHeaderDelegate {
  ProfileViewModel profileViewModel;
  final double maxExtent;
  final double minExtent;

  ProfileViewHeader(this.profileViewModel,
      {this.minExtent, @required this.maxExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        this.profileViewModel.getAvatarImagePath == null
            ? Image.asset('res/images/no_avatar.png', fit: BoxFit.cover)
            : Image.network(this.profileViewModel.getAvatarImagePath,
                fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 150),
          child: ProfileExitButton(this.profileViewModel),
        ),
        //ProfilePhotoEditButton(this.profileViewModel),
        Positioned(
          left: 24.0,
          right: 16.0,
          bottom: 16.0,
          child: ProfileTitleView(this.profileViewModel),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  TickerProvider get vsync => null;
}
