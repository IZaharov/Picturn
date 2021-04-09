import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';
import 'package:picturn/Views/CustomWidgets/stroke_text.dart';

class ProfileTitleView extends StatelessWidget {
  ProfileViewModel profileViewModel;

  ProfileTitleView(this.profileViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StrokeText(this.profileViewModel.profile.nickName,
              strokeColor: Colors.black,
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              strokeWidth: 0.8),
        ],
      ),
    );
  }
}
