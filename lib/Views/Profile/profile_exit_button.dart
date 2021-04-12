import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/login_view_model.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';

import '../../runtime_data.dart';

class ProfileExitButton extends StatelessWidget {
  ProfileViewModel profileViewModel;

  ProfileExitButton(this.profileViewModel);

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
                icon: Icon(Icons.exit_to_app, color: Colors.black),
                onPressed: () {
                  print("exit");
                  Navigator.pushReplacementNamed(context, '/login_view');
                }))
            : null);
  }
}