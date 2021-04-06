import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturn/ViewModels/post_view_model.dart';

class LikeView extends StatefulWidget {
  PostViewModel postViewModel;

  LikeView({Key key, this.postViewModel}) : super(key: key);

  State<StatefulWidget> createState() {
    return _LikeView(this.postViewModel);
  }
}

class _LikeView extends State<LikeView> {
  PostViewModel postViewModel;

  _LikeView(this.postViewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 7),
        child: Row(
          children: <Widget>[
            IconButton(
                splashRadius: 25,
                icon: this.postViewModel.getIsLiked
                    ? Icon(Icons.favorite_outlined, color: Colors.red)
                    : Icon(Icons.favorite_outline),
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    this.postViewModel.trySetLike();
                  });
                }),
            Padding(
                padding: EdgeInsets.only(left: 6, top: 0, right: 0, bottom: 0),
                child: Text('Нравится:  ' +
                    this.postViewModel.getLikesCount.toString()))
          ],
        ));
  }
}
