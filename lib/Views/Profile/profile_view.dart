import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/post_list_view_model.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';
import 'package:picturn/Views/Post/post_list_view.dart';
import 'package:picturn/Views/Profile/profile_view_header.dart';
import 'package:picturn/runtime_data.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  ProfileViewModel profileViewModel;
  PostListViewModel postListViewModel;

  ProfileView(this.profileViewModel){
    this.postListViewModel = PostListViewModel(PostListType.profile,
        profileViewModel: this.profileViewModel);
  }

  @override
  Widget build(BuildContext context) {
    RuntimeData.currentOpenProfileViewModel.profile =
        this.profileViewModel.profile;
    return ChangeNotifierProvider(
        create: (context) => this.postListViewModel,
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverPersistentHeader(
                      delegate: ProfileViewHeader(
                        this.profileViewModel,
                        minExtent: 250.0,
                        maxExtent: 250.0,
                      ),
                    )
                  ];
                },
                body: PostListView()),
            Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.fromLTRB(0, 40, 20, 0),
                child: !(RuntimeData.currentUserProfileViewModel
                        .equalProfiles(this.profileViewModel.profile))
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context);
                              RuntimeData.currentOpenProfileViewModel.profile =
                                  null;
                            }))
                    : null)
          ],
        )));
  }
}
