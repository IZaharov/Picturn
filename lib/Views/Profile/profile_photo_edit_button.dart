import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';
import 'file:///C:/Users/Zakharov/AndroidStudioProjects/picturn/lib/Views/Profile/profile_photo_edit_view.dart';

import '../../runtime_data.dart';

class ProfilePhotoEditButton extends StatelessWidget {
  ProfileViewModel profileViewModel;

  ProfilePhotoEditButton(this.profileViewModel);

  @override
  Widget build(BuildContext context) {
   return Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
        child: RuntimeData.currentUserProfileViewModel
            .equalProfiles(this.profileViewModel.profile)
            ? CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                icon: Icon(Icons.edit, color: Colors.black),
                onPressed: () {
                  print("edit avatar");
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfilePhotoEditView()));
                }))
            : null);
  }
}