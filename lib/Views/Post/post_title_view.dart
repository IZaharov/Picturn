import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/post_view_model.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';
import 'package:picturn/Views/CustomWidgets/stroke_text.dart';
import 'package:picturn/Views/Profile/profile_view.dart';
import 'package:picturn/runtime_data.dart';

class PostTitleView extends StatelessWidget {
  PostViewModel postViewModel;

  PostTitleView({this.postViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, top: 5, right: 5, bottom: 5),
        child: Row(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  if (RuntimeData.currentUserProfileViewModel
                      .equalProfiles(this.postViewModel.getProfile)) return;

                  if (RuntimeData.currentOpenProfileViewModel.profile != null &&
                      RuntimeData.currentOpenProfileViewModel
                          .equalProfiles(this.postViewModel.getProfile)) return;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileView(ProfileViewModel(
                              this.postViewModel.getProfile))));
                },
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.black,
                  backgroundImage:
                      this.postViewModel.getAvatarImagePath == null ||
                              this.postViewModel.getAvatarImagePath.isEmpty
                          ? AssetImage('res/images/no_avatar.png')
                          : NetworkImage(this.postViewModel.getAvatarImagePath),
                )),
            Padding(
                padding: EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.postViewModel.getAuthor,
                      style: TextStyle(fontSize: 16.5),
                    ),
                    Text(
                      formatDate(this.postViewModel.getDate, [HH, ':', nn]),
                      style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                    ),
                    Text(
                      formatDate(
                          this.postViewModel.getDate, [dd, '.', mm, '.', yyyy]),
                      style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                    ),
                  ],
                ))
          ],
        ));
  }
}
